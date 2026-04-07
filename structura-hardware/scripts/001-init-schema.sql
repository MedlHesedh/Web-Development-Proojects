-- Hardware Store Management System - Database Schema
-- Created for: Philippine Hardware Store in Bataan Province
-- Currency: Philippine Peso (PHP/₱)
-- VAT: 12% (BIR-compliant)

-- Enable necessary extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ============================================================================
-- CATEGORIES TABLE
-- ============================================================================
CREATE TABLE IF NOT EXISTS categories (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name VARCHAR(255) NOT NULL UNIQUE,
  description TEXT,
  icon VARCHAR(50),
  display_order INTEGER DEFAULT 0,
  active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================================
-- SUPPLIERS TABLE
-- ============================================================================
CREATE TABLE IF NOT EXISTS suppliers (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name VARCHAR(255) NOT NULL,
  contact_person VARCHAR(255),
  email VARCHAR(255),
  phone VARCHAR(20),
  address TEXT,
  city VARCHAR(100),
  province VARCHAR(100),
  notes TEXT,
  active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================================
-- PRODUCTS TABLE
-- ============================================================================
CREATE TABLE IF NOT EXISTS products (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  sku VARCHAR(50) NOT NULL UNIQUE,
  name VARCHAR(255) NOT NULL,
  description TEXT,
  category_id UUID NOT NULL REFERENCES categories(id) ON DELETE SET NULL,
  supplier_id UUID REFERENCES suppliers(id) ON DELETE SET NULL,
  
  -- Pricing (all in PHP - Philippine Peso)
  cost_price DECIMAL(10, 2) NOT NULL,          -- Cost to store (before VAT)
  selling_price DECIMAL(10, 2) NOT NULL,       -- Retail price (before VAT)
  vat_rate DECIMAL(5, 2) DEFAULT 12.00,        -- Percentage (typically 12% for BIR compliance)
  
  -- Physical Properties
  unit_of_measure VARCHAR(50) DEFAULT 'piece',  -- e.g., 'piece', 'bundle', 'meter', 'kg', 'box'
  reorder_point INTEGER DEFAULT 10,             -- Low stock threshold
  
  active BOOLEAN DEFAULT TRUE,
  notes TEXT,
  
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create index on SKU for fast lookups
CREATE INDEX IF NOT EXISTS idx_products_sku ON products(sku);
CREATE INDEX IF NOT EXISTS idx_products_category_id ON products(category_id);

-- ============================================================================
-- INVENTORY_STOCK TABLE
-- ============================================================================
CREATE TABLE IF NOT EXISTS inventory_stock (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  product_id UUID NOT NULL UNIQUE REFERENCES products(id) ON DELETE CASCADE,
  quantity_on_hand INTEGER NOT NULL DEFAULT 0,
  quantity_reserved INTEGER NOT NULL DEFAULT 0,  -- For future orders
  quantity_available INTEGER GENERATED ALWAYS AS (quantity_on_hand - quantity_reserved) STORED,
  last_counted_at TIMESTAMP WITH TIME ZONE,
  location_bin VARCHAR(50),  -- Storage location e.g., 'A1-01', 'B2-03'
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================================
-- STOCK_MOVEMENTS TABLE (Audit Trail - Immutable)
-- ============================================================================
CREATE TABLE IF NOT EXISTS stock_movements (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  product_id UUID NOT NULL REFERENCES products(id) ON DELETE CASCADE,
  movement_type VARCHAR(50) NOT NULL,  -- 'IN', 'OUT', 'ADJUSTMENT', 'DAMAGE', 'RETURN'
  quantity_change INTEGER NOT NULL,    -- Positive for IN/adjustment increases, negative for OUT
  quantity_before INTEGER NOT NULL,
  quantity_after INTEGER NOT NULL,
  reference_type VARCHAR(100),         -- e.g., 'POS_ORDER', 'PURCHASE_ORDER', 'PHYSICAL_COUNT'
  reference_id VARCHAR(100),           -- e.g., order ID or batch number
  notes TEXT,
  performed_by UUID REFERENCES auth.users(id) ON DELETE SET NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create indexes for audit trail queries
CREATE INDEX IF NOT EXISTS idx_stock_movements_product_id ON stock_movements(product_id);
CREATE INDEX IF NOT EXISTS idx_stock_movements_created_at ON stock_movements(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_stock_movements_movement_type ON stock_movements(movement_type);

-- ============================================================================
-- VAT_CONFIGURATION TABLE
-- ============================================================================
CREATE TABLE IF NOT EXISTS vat_configuration (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  vat_rate DECIMAL(5, 2) NOT NULL DEFAULT 12.00,
  effective_from DATE NOT NULL,
  effective_to DATE,
  notes TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================================
-- Create initial VAT configuration (12% - BIR standard)
-- ============================================================================
INSERT INTO vat_configuration (vat_rate, effective_from, notes)
VALUES (12.00, CURRENT_DATE, 'BIR-compliant VAT rate for Philippine hardware stores');

-- ============================================================================
-- ROW LEVEL SECURITY (RLS)
-- ============================================================================

-- Enable RLS on all tables
ALTER TABLE categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE suppliers ENABLE ROW LEVEL SECURITY;
ALTER TABLE products ENABLE ROW LEVEL SECURITY;
ALTER TABLE inventory_stock ENABLE ROW LEVEL SECURITY;
ALTER TABLE stock_movements ENABLE ROW LEVEL SECURITY;
ALTER TABLE vat_configuration ENABLE ROW LEVEL SECURITY;

-- For MVP, allow authenticated users to read all data, but restrict writes
-- Products: authenticated users can read, only admin can write (to be enforced in app)
CREATE POLICY "Allow authenticated users to read products"
  ON products FOR SELECT
  USING (auth.role() = 'authenticated');

CREATE POLICY "Allow authenticated users to read categories"
  ON categories FOR SELECT
  USING (auth.role() = 'authenticated');

CREATE POLICY "Allow authenticated users to read inventory"
  ON inventory_stock FOR SELECT
  USING (auth.role() = 'authenticated');

CREATE POLICY "Allow authenticated users to read stock movements"
  ON stock_movements FOR SELECT
  USING (auth.role() = 'authenticated');

CREATE POLICY "Allow authenticated users to read suppliers"
  ON suppliers FOR SELECT
  USING (auth.role() = 'authenticated');

CREATE POLICY "Allow authenticated users to read VAT config"
  ON vat_configuration FOR SELECT
  USING (auth.role() = 'authenticated');

-- Create policies for inserting stock movements (audit trail)
CREATE POLICY "Allow authenticated users to insert stock movements"
  ON stock_movements FOR INSERT
  WITH CHECK (auth.role() = 'authenticated');

-- ============================================================================
-- VIEWS (Optional - for easier querying)
-- ============================================================================

-- Product with current stock and pricing info
CREATE OR REPLACE VIEW product_inventory_view AS
SELECT
  p.id,
  p.sku,
  p.name,
  p.description,
  c.name as category_name,
  s.name as supplier_name,
  p.cost_price,
  p.selling_price,
  p.vat_rate,
  (p.selling_price * (1 + p.vat_rate / 100.0))::DECIMAL(10, 2) as selling_price_with_vat,
  ((p.selling_price - p.cost_price) / NULLIF(p.selling_price, 0) * 100)::DECIMAL(5, 2) as margin_percent,
  p.unit_of_measure,
  p.reorder_point,
  ist.quantity_on_hand,
  ist.quantity_reserved,
  ist.quantity_available,
  CASE
    WHEN ist.quantity_available <= 0 THEN 'OUT_OF_STOCK'
    WHEN ist.quantity_available <= p.reorder_point THEN 'LOW_STOCK'
    ELSE 'IN_STOCK'
  END as stock_status,
  p.active,
  p.created_at,
  p.updated_at
FROM products p
LEFT JOIN categories c ON p.category_id = c.id
LEFT JOIN suppliers s ON p.supplier_id = s.id
LEFT JOIN inventory_stock ist ON p.id = ist.product_id;

-- Stock movement summary by product
CREATE OR REPLACE VIEW stock_movement_summary_view AS
SELECT
  product_id,
  COUNT(*) as total_movements,
  SUM(CASE WHEN movement_type = 'IN' THEN quantity_change ELSE 0 END) as total_in,
  SUM(CASE WHEN movement_type = 'OUT' THEN quantity_change ELSE 0 END) as total_out,
  SUM(CASE WHEN movement_type = 'ADJUSTMENT' THEN quantity_change ELSE 0 END) as total_adjustments,
  MAX(created_at) as last_movement_at
FROM stock_movements
GROUP BY product_id;
