import { supabase } from '@/lib/supabase'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { Package, AlertTriangle, TrendingUp, DollarSign } from 'lucide-react'

async function getDashboardStats() {
  try {
    // Total products
    const { count: totalProducts } = await supabase
      .from('products')
      .select('*', { count: 'exact', head: true })
      .eq('active', true)

    // Low stock items
    const { data: lowStockData } = await supabase
      .from('inventory_stock')
      .select(`
        product_id,
        quantity_on_hand,
        products(reorder_point, name)
      `)
      .lt('quantity_on_hand', 'products(reorder_point)')

    // Total inventory value
    const { data: inventoryData } = await supabase
      .from('inventory_stock')
      .select(`
        quantity_on_hand,
        products(selling_price)
      `)

    const inventoryValue = inventoryData?.reduce((total, item: any) => {
      return total + (item.quantity_on_hand * (item.products?.selling_price || 0))
    }, 0) || 0

    return {
      totalProducts: totalProducts || 0,
      lowStockCount: lowStockData?.length || 0,
      inventoryValue: Math.round(inventoryValue),
      lastUpdated: new Date().toLocaleString('en-US', { 
        timeZone: 'Asia/Manila',
        month: 'short',
        day: 'numeric',
        hour: '2-digit',
        minute: '2-digit'
      })
    }
  } catch (error) {
    console.error('Error fetching dashboard stats:', error)
    return {
      totalProducts: 0,
      lowStockCount: 0,
      inventoryValue: 0,
      lastUpdated: 'N/A'
    }
  }
}

export default async function DashboardPage() {
  const stats = await getDashboardStats()

  return (
    <div className="flex-1 space-y-8 p-8 lg:p-12">
      <div className="space-y-2">
        <h1 className="text-3xl font-bold tracking-tight text-slate-900">Dashboard</h1>
        <p className="text-slate-600">Welcome to your hardware store inventory system. Last updated: {stats.lastUpdated}</p>
      </div>

      <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-4">
        {/* Total Products Card */}
        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium text-slate-700">Total Products</CardTitle>
            <Package className="h-4 w-4 text-blue-600" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-slate-900">{stats.totalProducts}</div>
            <p className="text-xs text-slate-500 mt-1">Active products in catalog</p>
          </CardContent>
        </Card>

        {/* Low Stock Card */}
        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium text-slate-700">Low Stock</CardTitle>
            <AlertTriangle className="h-4 w-4 text-yellow-600" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-slate-900">{stats.lowStockCount}</div>
            <p className="text-xs text-slate-500 mt-1">Items below reorder point</p>
          </CardContent>
        </Card>

        {/* Inventory Value Card */}
        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium text-slate-700">Inventory Value</CardTitle>
            <DollarSign className="h-4 w-4 text-green-600" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-slate-900">₱{(stats.inventoryValue / 1000).toFixed(1)}k</div>
            <p className="text-xs text-slate-500 mt-1">Total stock value at selling price</p>
          </CardContent>
        </Card>

        {/* Categories Card */}
        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium text-slate-700">Categories</CardTitle>
            <TrendingUp className="h-4 w-4 text-purple-600" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-slate-900">10</div>
            <p className="text-xs text-slate-500 mt-1">Product categories tracked</p>
          </CardContent>
        </Card>
      </div>

      {/* Quick Info Section */}
      <Card>
        <CardHeader>
          <CardTitle>Getting Started</CardTitle>
          <CardDescription>
            Manage your hardware store inventory efficiently
          </CardDescription>
        </CardHeader>
        <CardContent className="space-y-4">
          <div className="grid md:grid-cols-3 gap-4">
            <div className="space-y-2">
              <h3 className="font-medium text-slate-900">View Products</h3>
              <p className="text-sm text-slate-600">
                Browse your complete product catalog organized by category.
              </p>
            </div>
            <div className="space-y-2">
              <h3 className="font-medium text-slate-900">Track Inventory</h3>
              <p className="text-sm text-slate-600">
                Monitor stock levels and get alerts for low stock items.
              </p>
            </div>
            <div className="space-y-2">
              <h3 className="font-medium text-slate-900">View History</h3>
              <p className="text-sm text-slate-600">
                Check stock movement audit trail for transparency.
              </p>
            </div>
          </div>
        </CardContent>
      </Card>
    </div>
  )
}
