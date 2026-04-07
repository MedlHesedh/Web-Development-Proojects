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
import { Plus, Search } from 'lucide-react'

interface Product {
  id: string
  sku: string
  name: string
  description: string
  cost_price: number
  selling_price: number
  vat_rate: number
  unit_of_measure: string
  reorder_point: number
  active: boolean
  categories?: { name: string }
  suppliers?: { name: string }
  inventory_stock?: { quantity_on_hand: number }[]
}

async function getProducts() {
  try {
    const { data, error } = await supabase
      .from('products')
      .select(`
        id,
        sku,
        name,
        description,
        cost_price,
        selling_price,
        vat_rate,
        unit_of_measure,
        reorder_point,
        active,
        categories(name),
        suppliers(name),
        inventory_stock(quantity_on_hand)
      `)
      .eq('active', true)
      .order('name')
      .limit(100)

    if (error) throw error
    return data as Product[]
  } catch (error) {
    console.error('Error fetching products:', error)
    return []
  }
}

export default async function ProductsPage() {
  const products = await getProducts()

  const getStockStatus = (quantity: number, reorderPoint: number) => {
    if (quantity === 0) return { label: 'Out of Stock', color: 'bg-red-100 text-red-800' }
    if (quantity <= reorderPoint) return { label: 'Low Stock', color: 'bg-yellow-100 text-yellow-800' }
    return { label: 'In Stock', color: 'bg-green-100 text-green-800' }
  }

  return (
    <div className="space-y-8 p-8 lg:p-12">
      <div className="flex items-center justify-between">
        <div className="space-y-2">
          <h1 className="text-3xl font-bold tracking-tight text-slate-900">Products</h1>
          <p className="text-slate-600">Manage your hardware store product catalog</p>
        </div>
        <Button>
          <Plus className="w-4 h-4 mr-2" />
          Add Product
        </Button>
      </div>

      <Card>
        <CardHeader>
          <CardTitle>Product Catalog</CardTitle>
          <CardDescription>
            {products.length} products in your inventory
          </CardDescription>
        </CardHeader>
        <CardContent>
          <div className="space-y-4">
            {/* Search Bar */}
            <div className="relative">
              <Search className="absolute left-3 top-3 h-4 w-4 text-slate-400" />
              <Input
                placeholder="Search by product name or SKU..."
                className="pl-10"
              />
            </div>

            {/* Products Table */}
            <div className="border rounded-lg overflow-hidden">
              <Table>
                <TableHeader>
                  <TableRow className="bg-slate-50">
                    <TableHead className="w-[120px]">SKU</TableHead>
                    <TableHead>Product Name</TableHead>
                    <TableHead className="w-[100px]">Category</TableHead>
                    <TableHead className="text-right w-[100px]">Stock</TableHead>
                    <TableHead className="text-right w-[120px]">Selling Price</TableHead>
                    <TableHead className="w-[120px]">Status</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {products.length === 0 ? (
                    <TableRow>
                      <TableCell colSpan={6} className="text-center py-8">
                        <p className="text-slate-500">No products found</p>
                      </TableCell>
                    </TableRow>
                  ) : (
                    products.map((product) => {
                      const quantity = product.inventory_stock?.[0]?.quantity_on_hand || 0
                      const status = getStockStatus(quantity, product.reorder_point)
                      return (
                        <TableRow key={product.id} className="hover:bg-slate-50">
                          <TableCell className="font-mono text-sm text-slate-600">
                            {product.sku}
                          </TableCell>
                          <TableCell>
                            <div>
                              <p className="font-medium text-slate-900">{product.name}</p>
                              <p className="text-xs text-slate-500 mt-1">
                                {product.unit_of_measure}
                              </p>
                            </div>
                          </TableCell>
                          <TableCell className="text-sm text-slate-600">
                            {(product.categories as any)?.name || 'N/A'}
                          </TableCell>
                          <TableCell className="text-right font-medium text-slate-900">
                            {quantity}
                          </TableCell>
                          <TableCell className="text-right text-slate-900">
                            ₱{product.selling_price.toFixed(2)}
                          </TableCell>
                          <TableCell>
                            <Badge className={`${status.color} border-0`}>
                              {status.label}
                            </Badge>
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
