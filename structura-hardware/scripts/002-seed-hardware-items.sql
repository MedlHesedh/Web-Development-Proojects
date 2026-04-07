-- Hardware Store Seed Data
-- Realistic Philippine hardware store products for Bataan Province
-- All prices in PHP (Philippine Peso)

-- ============================================================================
-- CATEGORIES
-- ============================================================================
INSERT INTO categories (id, name, description, icon, display_order, active) VALUES
  ('550e8400-e29b-41d4-a716-446655440001'::uuid, 'Roofing Materials', 'G.I. sheets, roof fasteners, flashings', 'roof', 1, TRUE),
  ('550e8400-e29b-41d4-a716-446655440002'::uuid, 'Cement & Aggregates', 'Portland cement, sand, gravel, ready-mix', 'cement', 2, TRUE),
  ('550e8400-e29b-41d4-a716-446655440003'::uuid, 'Plumbing Supplies', 'Pipes, fittings, valves, fixtures', 'plumbing', 3, TRUE),
  ('550e8400-e29b-41d4-a716-446655440004'::uuid, 'Electrical Supplies', 'Wire, conduits, breakers, switches', 'electrical', 4, TRUE),
  ('550e8400-e29b-41d4-a716-446655440005'::uuid, 'Hardware & Fasteners', 'Nails, bolts, hinges, locks', 'hardware', 5, TRUE),
  ('550e8400-e29b-41d4-a716-446655440006'::uuid, 'Hand Tools', 'Hammers, wrenches, saws, levels', 'tools', 6, TRUE),
  ('550e8400-e29b-41d4-a716-446655440007'::uuid, 'Power Tools & Machinery', 'Drills, circular saws, angle grinders', 'power-tools', 7, TRUE),
  ('550e8400-e29b-41d4-a716-446655440008'::uuid, 'Lumber & Wood Products', 'Plywood, lumber, boards', 'wood', 8, TRUE),
  ('550e8400-e29b-41d4-a716-446655440009'::uuid, 'Paint & Finishing', 'Paints, varnish, thinner, brushes', 'paint', 9, TRUE),
  ('550e8400-e29b-41d4-a716-44665544000a'::uuid, 'Safety Equipment', 'Hard hats, gloves, masks, goggles', 'safety', 10, TRUE);

-- ============================================================================
-- SUPPLIERS
-- ============================================================================
INSERT INTO suppliers (id, name, contact_person, email, phone, city, province, active) VALUES
  ('660e8400-e29b-41d4-a716-446655440001'::uuid, 'Metro Steel & Roofing', 'Mr. Santos', 'santos@metrosteel.com.ph', '(043) 723-4567', 'Balanga', 'Bataan', TRUE),
  ('660e8400-e29b-41d4-a716-446655440002'::uuid, 'Cemento Filipinas', 'Ms. Cruz', 'sales@cementofilipinas.com', '(02) 8888-5555', 'Manila', 'Metro Manila', TRUE),
  ('660e8400-e29b-41d4-a716-446655440003'::uuid, 'Apex Plumbing Center', 'Mr. Garcia', 'apexplumbing@mail.com', '(049) 555-1234', 'Cabanatuan', 'Nueva Ecija', TRUE),
  ('660e8400-e29b-41d4-a716-446655440004'::uuid, 'ElectriMax Supplies', 'Ms. Reyes', 'orders@electrimax.com.ph', '(02) 8777-3333', 'Manila', 'Metro Manila', TRUE),
  ('660e8400-e29b-41d4-a716-446655440005'::uuid, 'SMC Tools & Hardware', 'Mr. Flores', 'wholesale@smctools.com.ph', '(043) 300-7890', 'Balanga', 'Bataan', TRUE);

-- ============================================================================
-- PRODUCTS - ROOFING MATERIALS
-- ============================================================================
INSERT INTO products (id, sku, name, description, category_id, supplier_id, cost_price, selling_price, vat_rate, unit_of_measure, reorder_point, active) VALUES
  ('770e8400-e29b-41d4-a716-446655440001'::uuid, 'GI-SHEET-04-100', 'G.I. Sheet 0.4mm 1.0 x 2.0m', 'Galvanized iron roofing sheet, standard thickness', '550e8400-e29b-41d4-a716-446655440001'::uuid, '660e8400-e29b-41d4-a716-446655440001'::uuid, 450.00, 599.00, 12.00, 'sheet', 5, TRUE),
  ('770e8400-e29b-41d4-a716-446655440002'::uuid, 'GI-SHEET-05-100', 'G.I. Sheet 0.5mm 1.0 x 2.0m', 'Galvanized iron roofing sheet, heavy gauge', '550e8400-e29b-41d4-a716-446655440001'::uuid, '660e8400-e29b-41d4-a716-446655440001'::uuid, 550.00, 725.00, 12.00, 'sheet', 5, TRUE),
  ('770e8400-e29b-41d4-a716-446655440003'::uuid, 'ZINC-RIDGE-CAP', 'Ridge Cap G.I. 2.4m', 'Galvanized ridge cap for roofing', '550e8400-e29b-41d4-a716-446655440001'::uuid, '660e8400-e29b-41d4-a716-446655440001'::uuid, 280.00, 380.00, 12.00, 'piece', 8, TRUE),
  ('770e8400-e29b-41d4-a716-446655440004'::uuid, 'ROOF-SCREW-WASHER', 'Roofing Screws with Washer 35mm (1kg)', 'Stainless steel roofing fasteners with rubber washers', '550e8400-e29b-41d4-a716-446655440001'::uuid, '660e8400-e29b-41d4-a716-446655440001'::uuid, 85.00, 145.00, 12.00, 'pack', 10, TRUE);

-- ============================================================================
-- PRODUCTS - CEMENT & AGGREGATES
-- ============================================================================
INSERT INTO products (id, sku, name, description, category_id, supplier_id, cost_price, selling_price, vat_rate, unit_of_measure, reorder_point, active) VALUES
  ('770e8400-e29b-41d4-a716-446655440005'::uuid, 'PORT-CEMENT-40KG', 'Portland Cement 40kg', 'Type I Portland cement, BIR-certified quality', '550e8400-e29b-41d4-a716-446655440002'::uuid, '660e8400-e29b-41d4-a716-446655440002'::uuid, 185.00, 245.00, 12.00, 'bag', 20, TRUE),
  ('770e8400-e29b-41d4-a716-446655440006'::uuid, 'MASONRY-CEMENT-40', 'Masonry Cement 40kg', 'Masonry cement for mortar and grout', '550e8400-e29b-41d4-a716-446655440002'::uuid, '660e8400-e29b-41d4-a716-446655440002'::uuid, 190.00, 255.00, 12.00, 'bag', 15, TRUE),
  ('770e8400-e29b-41d4-a716-446655440007'::uuid, 'SAND-CONSTRUCTION-TONS', 'Construction Sand 1 Ton', 'Natural washed sand for concrete and masonry', '550e8400-e29b-41d4-a716-446655440002'::uuid, '660e8400-e29b-41d4-a716-446655440002'::uuid, 350.00, 475.00, 12.00, 'ton', 5, TRUE),
  ('770e8400-e29b-41d4-a716-446655440008'::uuid, 'GRAVEL-10MM-TONS', 'Gravel 10mm 1 Ton', 'Clean 10mm gravel for concrete base', '550e8400-e29b-41d4-a716-446655440002'::uuid, '660e8400-e29b-41d4-a716-446655440002'::uuid, 400.00, 550.00, 12.00, 'ton', 5, TRUE),
  ('770e8400-e29b-41d4-a716-446655440009'::uuid, 'READY-MIX-CONCRETE', 'Ready-Mix Concrete per cubic meter', 'Pre-mixed concrete (minimum order 3 cu.m)', '550e8400-e29b-41d4-a716-446655440002'::uuid, '660e8400-e29b-41d4-a716-446655440002'::uuid, 2800.00, 3500.00, 12.00, 'cu.m', 1, TRUE);

-- ============================================================================
-- PRODUCTS - PLUMBING SUPPLIES
-- ============================================================================
INSERT INTO products (id, sku, name, description, category_id, supplier_id, cost_price, selling_price, vat_rate, unit_of_measure, reorder_point, active) VALUES
  ('770e8400-e29b-41d4-a716-44665544000a'::uuid, 'PVC-PIPE-05IN-3M', 'PVC Pipe 1/2 inch (3m)', 'PVC water supply pipe Schedule 40', '550e8400-e29b-41d4-a716-446655440003'::uuid, '660e8400-e29b-41d4-a716-446655440003'::uuid, 125.00, 175.00, 12.00, 'piece', 12, TRUE),
  ('770e8400-e29b-41d4-a716-44665544000b'::uuid, 'PVC-PIPE-075IN-3M', 'PVC Pipe 3/4 inch (3m)', 'PVC water supply pipe Schedule 40', '550e8400-e29b-41d4-a716-446655440003'::uuid, '660e8400-e29b-41d4-a716-446655440003'::uuid, 165.00, 235.00, 12.00, 'piece', 12, TRUE),
  ('770e8400-e29b-41d4-a716-44665544000c'::uuid, 'PVC-ELBOW-05IN', 'PVC Elbow 1/2 inch', 'PVC 90-degree elbow fitting', '550e8400-e29b-41d4-a716-446655440003'::uuid, '660e8400-e29b-41d4-a716-446655440003'::uuid, 15.00, 28.00, 12.00, 'piece', 20, TRUE),
  ('770e8400-e29b-41d4-a716-44665544000d'::uuid, 'PVC-TEE-05IN', 'PVC Tee 1/2 inch', 'PVC tee fitting', '550e8400-e29b-41d4-a716-446655440003'::uuid, '660e8400-e29b-41d4-a716-446655440003'::uuid, 18.00, 32.00, 12.00, 'piece', 20, TRUE),
  ('770e8400-e29b-41d4-a716-44665544000e'::uuid, 'BRASS-BALL-VALVE-05', 'Brass Ball Valve 1/2 inch', 'Full port ball valve for water supply', '550e8400-e29b-41d4-a716-446655440003'::uuid, '660e8400-e29b-41d4-a716-446655440003'::uuid, 185.00, 290.00, 12.00, 'piece', 8, TRUE),
  ('770e8400-e29b-41d4-a716-44665544000f'::uuid, 'PORCELAIN-TOILET-BOWL', 'Porcelain Toilet Bowl Standard', 'Single-piece porcelain toilet bowl fixture', '550e8400-e29b-41d4-a716-446655440003'::uuid, '660e8400-e29b-41d4-a716-446655440003'::uuid, 2500.00, 3850.00, 12.00, 'piece', 2, TRUE);

-- ============================================================================
-- PRODUCTS - ELECTRICAL SUPPLIES
-- ============================================================================
INSERT INTO products (id, sku, name, description, category_id, supplier_id, cost_price, selling_price, vat_rate, unit_of_measure, reorder_point, active) VALUES
  ('770e8400-e29b-41d4-a716-446655440010'::uuid, 'WIRE-THHN-25MM', 'Electrical Wire THHN 2.5mm (per meter)', 'Single-strand insulated copper wire', '550e8400-e29b-41d4-a716-446655440004'::uuid, '660e8400-e29b-41d4-a716-446655440004'::uuid, 8.50, 14.00, 12.00, 'meter', 30, TRUE),
  ('770e8400-e29b-41d4-a716-446655440011'::uuid, 'WIRE-THHN-40MM', 'Electrical Wire THHN 4.0mm (per meter)', 'Single-strand insulated copper wire', '550e8400-e29b-41d4-a716-446655440004'::uuid, '660e8400-e29b-41d4-a716-446655440004'::uuid, 12.50, 21.00, 12.00, 'meter', 25, TRUE),
  ('770e8400-e29b-41d4-a716-446655440012'::uuid, 'CONDUIT-PVC-20MM', 'PVC Conduit 20mm (per meter)', 'Rigid PVC electrical conduit', '550e8400-e29b-41d4-a716-446655440004'::uuid, '660e8400-e29b-41d4-a716-446655440004'::uuid, 35.00, 58.00, 12.00, 'meter', 20, TRUE),
  ('770e8400-e29b-41d4-a716-446655440013'::uuid, 'BREAKER-MCB-16A-1P', 'Miniature Circuit Breaker 16A 1-pole', 'DIN-type MCB for single-phase protection', '550e8400-e29b-41d4-a716-446655440004'::uuid, '660e8400-e29b-41d4-a716-446655440004'::uuid, 120.00, 198.00, 12.00, 'piece', 10, TRUE),
  ('770e8400-e29b-41d4-a716-446655440014'::uuid, 'LIGHT-SWITCH-SINGLE', 'Light Switch Single Pole', 'Standard white light switch with plate', '550e8400-e29b-41d4-a716-446655440004'::uuid, '660e8400-e29b-41d4-a716-446655440004'::uuid, 45.00, 85.00, 12.00, 'piece', 15, TRUE),
  ('770e8400-e29b-41d4-a716-446655440015'::uuid, 'POWER-OUTLET-DUPLEX', 'Duplex Power Outlet', 'Standard 220V electrical outlet with plate', '550e8400-e29b-41d4-a716-446655440004'::uuid, '660e8400-e29b-41d4-a716-446655440004'::uuid, 55.00, 105.00, 12.00, 'piece', 15, TRUE);

-- ============================================================================
-- PRODUCTS - HARDWARE & FASTENERS
-- ============================================================================
INSERT INTO products (id, sku, name, description, category_id, supplier_id, cost_price, selling_price, vat_rate, unit_of_measure, reorder_point, active) VALUES
  ('770e8400-e29b-41d4-a716-446655440016'::uuid, 'NAIL-GALV-2IN-1KG', 'Galvanized Nails 2 inches (1kg)', 'Corrosion-resistant steel nails', '550e8400-e29b-41d4-a716-446655440005'::uuid, '660e8400-e29b-41d4-a716-446655440005'::uuid, 35.00, 65.00, 12.00, 'pack', 25, TRUE),
  ('770e8400-e29b-41d4-a716-446655440017'::uuid, 'NAIL-GALV-3IN-1KG', 'Galvanized Nails 3 inches (1kg)', 'Corrosion-resistant steel nails for framing', '550e8400-e29b-41d4-a716-446655440005'::uuid, '660e8400-e29b-41d4-a716-446655440005'::uuid, 42.00, 78.00, 12.00, 'pack', 20, TRUE),
  ('770e8400-e29b-41d4-a716-446655440018'::uuid, 'BOLT-SS-M10-1.5IN', 'Stainless Steel Bolt M10 1.5 inches', 'Grade A4 stainless steel fastener', '550e8400-e29b-41d4-a716-446655440005'::uuid, '660e8400-e29b-41d4-a716-446655440005'::uuid, 8.00, 15.00, 12.00, 'piece', 15, TRUE),
  ('770e8400-e29b-41d4-a716-446655440019'::uuid, 'HINGE-STEEL-3IN', '3-inch Steel Hinge', 'Heavy-duty door hinge', '550e8400-e29b-41d4-a716-446655440005'::uuid, '660e8400-e29b-41d4-a716-446655440005'::uuid, 45.00, 85.00, 12.00, 'piece', 10, TRUE),
  ('770e8400-e29b-41d4-a716-44665544001a'::uuid, 'MORTISE-LOCK-BRASS', 'Mortise Lock Brass', 'Interior door mortise lock set', '550e8400-e29b-41d4-a716-446655440005'::uuid, '660e8400-e29b-41d4-a716-446655440005'::uuid, 280.00, 450.00, 12.00, 'piece', 5, TRUE),
  ('770e8400-e29b-41d4-a716-44665544001b'::uuid, 'PADLOCK-BRASS-40MM', '40mm Brass Padlock', 'Weather-resistant solid brass padlock', '550e8400-e29b-41d4-a716-446655440005'::uuid, '660e8400-e29b-41d4-a716-446655440005'::uuid, 85.00, 150.00, 12.00, 'piece', 8, TRUE);

-- ============================================================================
-- PRODUCTS - HAND TOOLS
-- ============================================================================
INSERT INTO products (id, sku, name, description, category_id, supplier_id, cost_price, selling_price, vat_rate, unit_of_measure, reorder_point, active) VALUES
  ('770e8400-e29b-41d4-a716-44665544001c'::uuid, 'HAMMER-CLAW-16OZ', 'Claw Hammer 16 oz', 'Steel head with wooden handle', '550e8400-e29b-41d4-a716-446655440006'::uuid, '660e8400-e29b-41d4-a716-446655440005'::uuid, 185.00, 320.00, 12.00, 'piece', 8, TRUE),
  ('770e8400-e29b-41d4-a716-44665544001d'::uuid, 'WRENCH-ADJUSTABLE-10IN', 'Adjustable Wrench 10 inches', 'Chrome-plated steel wrench', '550e8400-e29b-41d4-a716-446655440006'::uuid, '660e8400-e29b-41d4-a716-446655440005'::uuid, 150.00, 280.00, 12.00, 'piece', 6, TRUE),
  ('770e8400-e29b-41d4-a716-44665544001e'::uuid, 'HAND-SAW-WOOD-20IN', 'Hand Saw 20 inches', 'Tungsten carbide teeth for wood cutting', '550e8400-e29b-41d4-a716-446655440006'::uuid, '660e8400-e29b-41d4-a716-446655440005'::uuid, 210.00, 380.00, 12.00, 'piece', 5, TRUE),
  ('770e8400-e29b-41d4-a716-44665544001f'::uuid, 'LEVEL-SPIRIT-24IN', 'Spirit Level 24 inches', 'Aluminum frame with three bubble vials', '550e8400-e29b-41d4-a716-446655440006'::uuid, '660e8400-e29b-41d4-a716-446655440005'::uuid, 380.00, 650.00, 12.00, 'piece', 5, TRUE),
  ('770e8400-e29b-41d4-a716-446655440020'::uuid, 'TAPE-MEASURE-25FT', 'Tape Measure 25 ft', 'Steel retractable tape with lock', '550e8400-e29b-41d4-a716-446655440006'::uuid, '660e8400-e29b-41d4-a716-446655440005'::uuid, 95.00, 175.00, 12.00, 'piece', 10, TRUE),
  ('770e8400-e29b-41d4-a716-446655440021'::uuid, 'PUTTY-KNIFE-4IN', 'Putty Knife 4 inches', 'Steel blade for smoothing and scraping', '550e8400-e29b-41d4-a716-446655440006'::uuid, '660e8400-e29b-41d4-a716-446655440005'::uuid, 35.00, 68.00, 12.00, 'piece', 12, TRUE);

-- ============================================================================
-- PRODUCTS - POWER TOOLS & MACHINERY
-- ============================================================================
INSERT INTO products (id, sku, name, description, category_id, supplier_id, cost_price, selling_price, vat_rate, unit_of_measure, reorder_point, active) VALUES
  ('770e8400-e29b-41d4-a716-446655440022'::uuid, 'DRILL-CORDLESS-20V', 'Cordless Drill 20V Li-ion', 'Compact cordless drill with 2 batteries and charger', '550e8400-e29b-41d4-a716-446655440007'::uuid, '660e8400-e29b-41d4-a716-446655440005'::uuid, 1800.00, 2850.00, 12.00, 'piece', 2, TRUE),
  ('770e8400-e29b-41d4-a716-446655440023'::uuid, 'CIRCULAR-SAW-7IN', '7-inch Circular Saw', 'Electric circular saw for wood and metal cutting', '550e8400-e29b-41d4-a716-446655440007'::uuid, '660e8400-e29b-41d4-a716-446655440005'::uuid, 2200.00, 3500.00, 12.00, 'piece', 2, TRUE),
  ('770e8400-e29b-41d4-a716-446655440024'::uuid, 'ANGLE-GRINDER-4.5IN', '4.5-inch Angle Grinder', 'Compact angle grinder for metal cutting and grinding', '550e8400-e29b-41d4-a716-446655440007'::uuid, '660e8400-e29b-41d4-a716-446655440005'::uuid, 1200.00, 1950.00, 12.00, 'piece', 2, TRUE),
  ('770e8400-e29b-41d4-a716-446655440025'::uuid, 'IMPACT-DRIVER-20V', 'Impact Driver 20V Li-ion', 'Cordless impact driver with battery and charger', '550e8400-e29b-41d4-a716-446655440007'::uuid, '660e8400-e29b-41d4-a716-446655440005'::uuid, 1500.00, 2400.00, 12.00, 'piece', 2, TRUE);

-- ============================================================================
-- PRODUCTS - LUMBER & WOOD PRODUCTS
-- ============================================================================
INSERT INTO products (id, sku, name, description, category_id, supplier_id, cost_price, selling_price, vat_rate, unit_of_measure, reorder_point, active) VALUES
  ('770e8400-e29b-41d4-a716-446655440026'::uuid, 'PLYWOOD-3QTR-4X8', 'Plywood 3/4 inch (4x8 ft)', 'Birch veneer plywood sheet', '550e8400-e29b-41d4-a716-446655440008'::uuid, '660e8400-e29b-41d4-a716-446655440005'::uuid, 1100.00, 1650.00, 12.00, 'sheet', 8, TRUE),
  ('770e8400-e29b-41d4-a716-446655440027'::uuid, 'PLYWOOD-HALF-4X8', 'Plywood 1/2 inch (4x8 ft)', 'Multi-ply plywood sheet', '550e8400-e29b-41d4-a716-446655440008'::uuid, '660e8400-e29b-41d4-a716-446655440005'::uuid, 750.00, 1100.00, 12.00, 'sheet', 10, TRUE),
  ('770e8400-e29b-41d4-a716-446655440028'::uuid, 'LUMBER-2X4-8FT', 'Lumber 2x4 inches (8 ft)', 'SPF softwood lumber for framing', '550e8400-e29b-41d4-a716-446655440008'::uuid, '660e8400-e29b-41d4-a716-446655440005'::uuid, 185.00, 285.00, 12.00, 'piece', 15, TRUE),
  ('770e8400-e29b-41d4-a716-446655440029'::uuid, 'LUMBER-2X6-8FT', 'Lumber 2x6 inches (8 ft)', 'SPF softwood lumber for framing', '550e8400-e29b-41d4-a716-446655440008'::uuid, '660e8400-e29b-41d4-a716-446655440005'::uuid, 280.00, 430.00, 12.00, 'piece', 12, TRUE);

-- ============================================================================
-- PRODUCTS - PAINT & FINISHING
-- ============================================================================
INSERT INTO products (id, sku, name, description, category_id, supplier_id, cost_price, selling_price, vat_rate, unit_of_measure, reorder_point, active) VALUES
  ('770e8400-e29b-41d4-a716-44665544002a'::uuid, 'PAINT-LATEX-WHITE-1L', 'Latex Paint White 1 Liter', 'Water-based interior/exterior latex paint', '550e8400-e29b-41d4-a716-446655440009'::uuid, '660e8400-e29b-41d4-a716-446655440005'::uuid, 180.00, 320.00, 12.00, 'can', 15, TRUE),
  ('770e8400-e29b-41d4-a716-44665544002b'::uuid, 'PAINT-LATEX-WHITE-4L', 'Latex Paint White 4 Liters', 'Water-based interior/exterior latex paint', '550e8400-e29b-41d4-a716-446655440009'::uuid, '660e8400-e29b-41d4-a716-446655440005'::uuid, 620.00, 1085.00, 12.00, 'can', 10, TRUE),
  ('770e8400-e29b-41d4-a716-44665544002c'::uuid, 'BRUSH-PAINT-2IN', 'Paint Brush 2 inches', 'Nylon bristle paint brush', '550e8400-e29b-41d4-a716-446655440009'::uuid, '660e8400-e29b-41d4-a716-446655440005'::uuid, 45.00, 85.00, 12.00, 'piece', 20, TRUE),
  ('770e8400-e29b-41d4-a716-44665544002d'::uuid, 'PAINT-ROLLER-9IN', 'Paint Roller 9 inches', 'Foam paint roller with cover', '550e8400-e29b-41d4-a716-446655440009'::uuid, '660e8400-e29b-41d4-a716-446655440005'::uuid, 55.00, 105.00, 12.00, 'piece', 15, TRUE),
  ('770e8400-e29b-41d4-a716-44665544002e'::uuid, 'PAINT-THINNER-1L', 'Paint Thinner 1 Liter', 'General-purpose paint thinner', '550e8400-e29b-41d4-a716-446655440009'::uuid, '660e8400-e29b-41d4-a716-446655440005'::uuid, 85.00, 155.00, 12.00, 'can', 10, TRUE);

-- ============================================================================
-- PRODUCTS - SAFETY EQUIPMENT
-- ============================================================================
INSERT INTO products (id, sku, name, description, category_id, supplier_id, cost_price, selling_price, vat_rate, unit_of_measure, reorder_point, active) VALUES
  ('770e8400-e29b-41d4-a716-44665544002f'::uuid, 'HARD-HAT-YELLOW', 'Yellow Safety Hard Hat', 'ANSI Z89.1 certified hard hat', '550e8400-e29b-41d4-a716-44665544000a'::uuid, '660e8400-e29b-41d4-a716-446655440005'::uuid, 150.00, 280.00, 12.00, 'piece', 10, TRUE),
  ('770e8400-e29b-41d4-a716-446655440030'::uuid, 'GLOVES-WORK-LEATHER', 'Leather Work Gloves', 'Premium split leather work gloves', '550e8400-e29b-41d4-a716-44665544000a'::uuid, '660e8400-e29b-41d4-a716-446655440005'::uuid, 65.00, 125.00, 12.00, 'pair', 20, TRUE),
  ('770e8400-e29b-41d4-a716-446655440031'::uuid, 'MASK-DUST-N95-50PC', 'N95 Dust Mask (50 pcs)', 'Disposable N95 respiratory protection masks', '550e8400-e29b-41d4-a716-44665544000a'::uuid, '660e8400-e29b-41d4-a716-446655440005'::uuid, 185.00, 340.00, 12.00, 'pack', 15, TRUE),
  ('770e8400-e29b-41d4-a716-446655440032'::uuid, 'GOGGLES-SAFETY-CLEAR', 'Safety Goggles Clear', 'Polycarbonate safety goggles', '550e8400-e29b-41d4-a716-44665544000a'::uuid, '660e8400-e29b-41d4-a716-446655440005'::uuid, 85.00, 160.00, 12.00, 'piece', 12, TRUE),
  ('770e8400-e29b-41d4-a716-446655440033'::uuid, 'SAFETY-VEST-ORANGE', 'Orange Safety Vest', 'High-visibility safety vest with reflective strips', '550e8400-e29b-41d4-a716-44665544000a'::uuid, '660e8400-e29b-41d4-a716-446655440005'::uuid, 120.00, 225.00, 12.00, 'piece', 15, TRUE);

-- ============================================================================
-- INITIALIZE INVENTORY_STOCK TABLE
-- ============================================================================
INSERT INTO inventory_stock (product_id, quantity_on_hand, quantity_reserved, location_bin)
SELECT id, FLOOR(RANDOM() * 50 + 5)::int as quantity_on_hand, 0 as quantity_reserved,
  CASE 
    WHEN RANDOM() < 0.1 THEN 'A1'
    WHEN RANDOM() < 0.2 THEN 'A2'
    WHEN RANDOM() < 0.3 THEN 'B1'
    WHEN RANDOM() < 0.4 THEN 'B2'
    WHEN RANDOM() < 0.5 THEN 'C1'
    WHEN RANDOM() < 0.6 THEN 'C2'
    WHEN RANDOM() < 0.7 THEN 'D1'
    WHEN RANDOM() < 0.8 THEN 'D2'
    WHEN RANDOM() < 0.9 THEN 'E1'
    ELSE 'E2'
  END as location_bin
FROM products;

-- ============================================================================
-- Initialize stock movements audit trail
-- ============================================================================
INSERT INTO stock_movements (product_id, movement_type, quantity_change, quantity_before, quantity_after, reference_type, reference_id, notes)
SELECT id, 'IN', (SELECT quantity_on_hand FROM inventory_stock WHERE product_id = products.id), 
  0, (SELECT quantity_on_hand FROM inventory_stock WHERE product_id = products.id),
  'INITIAL_INVENTORY', 'INIT-001', 'Initial inventory load'
FROM products;
