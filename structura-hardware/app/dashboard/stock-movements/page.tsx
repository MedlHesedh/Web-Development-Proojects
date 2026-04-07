import { supabase } from '@/lib/supabase'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { Badge } from '@/components/ui/badge'
import { Input } from '@/components/ui/input'
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from '@/components/ui/table'
import { Search, TrendingUp, TrendingDown } from 'lucide-react'

interface StockMovement {
  id: string
  product_id: string
  movement_type: 'IN' | 'OUT' | 'ADJUSTMENT'
  quantity_change: number
  quantity_before: number
  quantity_after: number
  reference_type: string
  reference_id: string
  notes: string
  created_at: string
  products?: {
    sku: string
    name: string
  }
}

async function getStockMovements() {
  try {
    const { data, error } = await supabase
      .from('stock_movements')
      .select(`
        id,
        product_id,
        movement_type,
        quantity_change,
        quantity_before,
        quantity_after,
        reference_type,
        reference_id,
        notes,
        created_at,
        products(sku, name)
      `)
      .order('created_at', { ascending: false })
      .limit(200)

    if (error) throw error
    return data as StockMovement[]
  } catch (error) {
    console.error('Error fetching stock movements:', error)
    return []
  }
}

export default async function StockMovementsPage() {
  const movements = await getStockMovements()

  const getMovementBadge = (type: string) => {
    switch (type) {
      case 'IN':
        return { label: 'Stock In', color: 'bg-green-100 text-green-800', icon: TrendingUp }
      case 'OUT':
        return { label: 'Stock Out', color: 'bg-red-100 text-red-800', icon: TrendingDown }
      case 'ADJUSTMENT':
        return { label: 'Adjustment', color: 'bg-blue-100 text-blue-800', icon: TrendingUp }
      default:
        return { label: type, color: 'bg-slate-100 text-slate-800', icon: TrendingUp }
    }
  }

  const formatDate = (dateString: string) => {
    const date = new Date(dateString)
    return date.toLocaleString('en-US', {
      timeZone: 'Asia/Manila',
      month: 'short',
      day: 'numeric',
      year: 'numeric',
      hour: '2-digit',
      minute: '2-digit',
    })
  }

  return (
    <div className="space-y-8 p-8 lg:p-12">
      <div className="space-y-2">
        <h1 className="text-3xl font-bold tracking-tight text-slate-900">Stock Movements</h1>
        <p className="text-slate-600">Audit trail of all inventory transactions</p>
      </div>

      {/* Stock Movements Table */}
      <Card>
        <CardHeader>
          <CardTitle>Movement History</CardTitle>
          <CardDescription>
            {movements.length} movements recorded
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

            {/* Movements Table */}
            <div className="border rounded-lg overflow-hidden">
              <Table>
                <TableHeader>
                  <TableRow className="bg-slate-50">
                    <TableHead>Date & Time</TableHead>
                    <TableHead className="w-[120px]">SKU</TableHead>
                    <TableHead>Product</TableHead>
                    <TableHead className="w-[100px]">Type</TableHead>
                    <TableHead className="text-right w-[80px]">Quantity</TableHead>
                    <TableHead className="text-right w-[100px]">Before</TableHead>
                    <TableHead className="text-right w-[100px]">After</TableHead>
                    <TableHead>Reference</TableHead>
                    <TableHead>Notes</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {movements.length === 0 ? (
                    <TableRow>
                      <TableCell colSpan={9} className="text-center py-8">
                        <p className="text-slate-500">No stock movements found</p>
                      </TableCell>
                    </TableRow>
                  ) : (
                    movements.map((movement) => {
                      const badge = getMovementBadge(movement.movement_type)
                      const Icon = badge.icon
                      return (
                        <TableRow key={movement.id} className="hover:bg-slate-50">
                          <TableCell className="text-sm text-slate-600">
                            {formatDate(movement.created_at)}
                          </TableCell>
                          <TableCell className="font-mono text-sm text-slate-600">
                            {movement.products?.sku || 'N/A'}
                          </TableCell>
                          <TableCell className="text-sm font-medium text-slate-900">
                            {movement.products?.name || 'Unknown Product'}
                          </TableCell>
                          <TableCell>
                            <Badge className={`${badge.color} border-0 inline-flex items-center gap-1`}>
                              <Icon className="w-3 h-3" />
                              {badge.label}
                            </Badge>
                          </TableCell>
                          <TableCell className="text-right font-medium">
                            <span className={movement.quantity_change > 0 ? 'text-green-700' : 'text-red-700'}>
                              {movement.quantity_change > 0 ? '+' : ''}{movement.quantity_change}
                            </span>
                          </TableCell>
                          <TableCell className="text-right text-slate-600">
                            {movement.quantity_before}
                          </TableCell>
                          <TableCell className="text-right text-slate-600">
                            {movement.quantity_after}
                          </TableCell>
                          <TableCell className="text-sm text-slate-600">
                            {movement.reference_type} {movement.reference_id ? `(${movement.reference_id})` : ''}
                          </TableCell>
                          <TableCell className="text-sm text-slate-600 max-w-xs">
                            {movement.notes}
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
