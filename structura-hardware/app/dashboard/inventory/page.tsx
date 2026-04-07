import { supabase } from '@/lib/supabase'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { Badge } from '@/components/ui/badge'
import { Input } from '@/components/ui/input'
import { Button } from '@/components/ui/button'
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from '@/components/ui/table'
import { AlertTriangle, Search, Edit2 } from 'lucide-react'

interface InventoryItem {
  id: string
  product_id: string
  quantity_on_hand: number
  quantity_reserved: number
  location_bin: string
  products: {
    sku: string
    name: string
    reorder_point: number
    selling_price: number
  }
}

async function getInventory() {
  try {
    const { data, error } = await supabase
      .from('inventory_stock')
      .select(`
        id,
        product_id,
        quantity_on_hand,
        quantity_reserved,
        location_bin,
        products(sku, name, reorder_point, selling_price)
      `)
      .order('products(name)')

    if (error) throw error
    return data as InventoryItem[]
  } catch (error) {
    console.error('Error fetching inventory:', error)
    return []
  }
}

export default async function InventoryPage() {
  const inventory = await getInventory()

  const getStockStatus = (quantity: number, reorderPoint: number) => {
    if (quantity === 0) {
      return { label: 'Out of Stock', color: 'bg-red-100 text-red-800', icon: '⚠️' }
    }
    if (quantity <= reorderPoint) {
      return { label: 'Low Stock', color: 'bg-yellow-100 text-yellow-800', icon: '!' }
    }
    return { label: 'In Stock', color: 'bg-green-100 text-green-800', icon: '✓' }
  }

  const lowStockItems = inventory.filter(
    (item) => item.quantity_on_hand <= item.products.reorder_point
  )

  return (
    <div className="space-y-8 p-8 lg:p-12">
      <div className="space-y-2">
        <h1 className="text-3xl font-bold tracking-tight text-slate-900">Inventory</h1>
        <p className="text-slate-600">Real-time stock levels and location tracking</p>
      </div>

      {/* Low Stock Alert */}
      {lowStockItems.length > 0 && (
        <Card className="border-yellow-200 bg-yellow-50">
          <CardHeader className="flex flex-row items-center justify-between space-y-0">
            <div className="flex items-center gap-2">
              <AlertTriangle className="w-5 h-5 text-yellow-600" />
              <CardTitle className="text-yellow-900">Low Stock Alert</CardTitle>
            </div>
            <Badge variant="outline" className="bg-yellow-100 text-yellow-800 border-yellow-300">
              {lowStockItems.length} items
            </Badge>
          </CardHeader>
          <CardContent>
            <p className="text-sm text-yellow-700">
              {lowStockItems.length} product{lowStockItems.length !== 1 ? 's' : ''} below reorder point. Consider placing orders.
            </p>
          </CardContent>
        </Card>
      )}

      {/* Inventory Table */}
      <Card>
        <CardHeader>
          <CardTitle>Stock Levels</CardTitle>
          <CardDescription>
            {inventory.length} products tracked
          </CardDescription>
        </CardHeader>
        <CardContent>
          <div className="space-y-4">
            {/* Search Bar */}
            <div className="relative">
              <Search className="absolute left-3 top-3 h-4 w-4 text-slate-400" />
              <Input
                placeholder="Search inventory by product name or SKU..."
                className="pl-10"
              />
            </div>

            {/* Inventory Table */}
            <div className="border rounded-lg overflow-hidden">
              <Table>
                <TableHeader>
                  <TableRow className="bg-slate-50">
                    <TableHead className="w-[120px]">SKU</TableHead>
                    <TableHead>Product</TableHead>
                    <TableHead className="text-right w-[100px]">On Hand</TableHead>
                    <TableHead className="text-right w-[100px]">Reserved</TableHead>
                    <TableHead className="text-right w-[100px]">Reorder Point</TableHead>
                    <TableHead className="w-[80px]">Location</TableHead>
                    <TableHead className="w-[120px]">Status</TableHead>
                    <TableHead className="w-[50px]">Action</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {inventory.length === 0 ? (
                    <TableRow>
                      <TableCell colSpan={8} className="text-center py-8">
                        <p className="text-slate-500">No inventory records found</p>
                      </TableCell>
                    </TableRow>
                  ) : (
                    inventory.map((item) => {
                      const status = getStockStatus(
                        item.quantity_on_hand,
                        item.products.reorder_point
                      )
                      const value = (item.quantity_on_hand * item.products.selling_price).toLocaleString('en-PH', {
                        style: 'currency',
                        currency: 'PHP'
                      })

                      return (
                        <TableRow key={item.id} className="hover:bg-slate-50">
                          <TableCell className="font-mono text-sm text-slate-600">
                            {item.products.sku}
                          </TableCell>
                          <TableCell>
                            <div>
                              <p className="font-medium text-slate-900">
                                {item.products.name}
                              </p>
                              <p className="text-xs text-slate-500 mt-1">
                                {value}
                              </p>
                            </div>
                          </TableCell>
                          <TableCell className="text-right font-medium text-slate-900">
                            {item.quantity_on_hand}
                          </TableCell>
                          <TableCell className="text-right text-slate-600">
                            {item.quantity_reserved}
                          </TableCell>
                          <TableCell className="text-right text-slate-600">
                            {item.products.reorder_point}
                          </TableCell>
                          <TableCell className="font-mono text-sm bg-slate-50 text-slate-700">
                            {item.location_bin}
                          </TableCell>
                          <TableCell>
                            <Badge className={`${status.color} border-0`}>
                              {status.label}
                            </Badge>
                          </TableCell>
                          <TableCell>
                            <Button variant="ghost" size="sm">
                              <Edit2 className="w-4 h-4" />
                            </Button>
                          </TableCell>
                        </TableRow>
                      )
                    })
                  )}
                </TableBody>
              </Table>
            </div>
          </div>
        </CardContent>
      </Card>
    </div>
  )
}
