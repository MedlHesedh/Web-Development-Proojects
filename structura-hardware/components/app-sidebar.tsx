'use client'

import Link from 'next/link'
import { usePathname } from 'next/navigation'
import { useAuth } from '@/hooks/useAuth'
import {
  Sidebar,
  SidebarContent,
  SidebarFooter,
  SidebarGroup,
  SidebarGroupLabel,
  SidebarHeader,
  SidebarMenu,
  SidebarMenuBadge,
  SidebarMenuButton,
  SidebarMenuItem,
  SidebarSeparator,
  useSidebar,
} from '@/components/ui/sidebar'
import { Avatar, AvatarFallback } from '@/components/ui/avatar'
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from '@/components/ui/dropdown-menu'
import {
  LayoutDashboard,
  ShoppingCart,
  ClipboardList,
  Package,
  ArrowLeftRight,
  AlertTriangle,
  Truck,
  Building2,
  BarChart2,
  FileText,
  Tag,
  Settings,
  LogOut,
  ChevronsUpDown,
  Store,
} from 'lucide-react'

const navSections = [
  {
    label: 'SALES',
    items: [
      { href: '/dashboard', label: 'Dashboard', icon: LayoutDashboard },
      { href: '/dashboard/pos', label: 'POS / Walk-in', icon: ShoppingCart },
      { href: '/dashboard/orders', label: 'Orders', icon: ClipboardList },
    ],
  },
  {
    label: 'INVENTORY',
    items: [
      { href: '/dashboard/products', label: 'Products', icon: Package },
      { href: '/dashboard/stock-movements', label: 'Stock Movement', icon: ArrowLeftRight },
      { href: '/dashboard/low-stock', label: 'Low Stock Alerts', icon: AlertTriangle, badge: true },
    ],
  },
  {
    label: 'PURCHASING',
    items: [
      { href: '/dashboard/purchase-orders', label: 'Purchase Orders', icon: Truck },
      { href: '/dashboard/suppliers', label: 'Suppliers', icon: Building2 },
    ],
  },
  {
    label: 'REPORTS',
    items: [
      { href: '/dashboard/reports/sales', label: 'Sales Reports', icon: BarChart2 },
      { href: '/dashboard/reports/inventory', label: 'Inventory Reports', icon: FileText },
    ],
  },
  {
    label: 'SETTINGS',
    items: [
      { href: '/dashboard/pricing', label: 'Pricing', icon: Tag },
      { href: '/dashboard/settings', label: 'Store Settings', icon: Settings },
    ],
  },
]

const LOW_STOCK_COUNT = 4

export function AppSidebar() {
  const pathname = usePathname()
  const { user, logout } = useAuth()
  const { isMobile } = useSidebar()

  const isActive = (href: string) => {
    if (href === '/dashboard') return pathname === '/dashboard'
    return pathname === href || pathname.startsWith(`${href}/`)
  }

  const initials = user?.email
    ? user.email.slice(0, 2).toUpperCase()
    : 'MH'

  const displayEmail = user?.email ?? 'owner@medlhardware.com'

  return (
    <Sidebar collapsible={isMobile ? 'offcanvas' : 'icon'}>
      {/* Store header */}
      <SidebarHeader className="border-b border-white/[0.08] px-3 py-3">
        <div className="flex items-center gap-2.5 px-1">
          <div className="flex h-7 w-7 shrink-0 items-center justify-center rounded-md bg-[#5e6ad2]/20 border border-[#5e6ad2]/30">
            <Store className="h-3.5 w-3.5 text-[#7170ff]" />
          </div>
          <div className="flex flex-col group-data-[collapsible=icon]:hidden">
            <span className="text-[13px] font-[510] leading-none text-[#f7f8f8]" style={{ fontFeatureSettings: '"cv01", "ss03"' }}>
              Medl Hardware
            </span>
            <span className="mt-0.5 text-[11px] font-[400] text-[#62666d]" style={{ fontFeatureSettings: '"cv01", "ss03"' }}>
              Bataan Province
            </span>
          </div>
        </div>
      </SidebarHeader>

      {/* Nav sections */}
      <SidebarContent className="gap-0 py-2">
        {navSections.map((section, sectionIdx) => (
          <SidebarGroup key={section.label} className="px-2 py-0">
            {sectionIdx > 0 && (
              <SidebarSeparator className="mx-0 mb-1 mt-2 bg-white/[0.05]" />
            )}
            <SidebarGroupLabel
              className="px-2 py-1 text-[10px] font-[510] tracking-widest text-[#62666d] group-data-[collapsible=icon]:hidden"
              style={{ fontFeatureSettings: '"cv01", "ss03"' }}
            >
              {section.label}
            </SidebarGroupLabel>
            <SidebarMenu>
              {section.items.map((item) => {
                const active = isActive(item.href)
                const Icon = item.icon
                return (
                  <SidebarMenuItem key={item.href}>
                    <SidebarMenuButton
                      asChild
                      isActive={active}
                      tooltip={item.label}
                      className={[
                        'h-8 rounded-md px-2 text-[13px] font-[510] transition-colors',
                        'group-data-[collapsible=icon]:justify-center group-data-[collapsible=icon]:px-0',
                        active
                          ? 'bg-white/[0.06] text-[#f7f8f8]'
                          : 'text-[#8a8f98] hover:bg-white/[0.04] hover:text-[#d0d6e0]',
                      ].join(' ')}
                      style={{ fontFeatureSettings: '"cv01", "ss03"' }}
                    >
                      <Link href={item.href}>
                        <Icon
                          className={[
                            'h-4 w-4 shrink-0',
                            active ? 'text-[#7170ff]' : 'text-current',
                          ].join(' ')}
                        />
                        <span className="group-data-[collapsible=icon]:hidden">{item.label}</span>
                      </Link>
                    </SidebarMenuButton>
                    {item.badge && LOW_STOCK_COUNT > 0 && (
                      <SidebarMenuBadge className="group-data-[collapsible=icon]:hidden rounded-full bg-amber-500/15 px-1.5 text-[10px] font-[510] text-amber-400">
                        {LOW_STOCK_COUNT}
                      </SidebarMenuBadge>
                    )}
                  </SidebarMenuItem>
                )
              })}
            </SidebarMenu>
          </SidebarGroup>
        ))}
      </SidebarContent>

      {/* User footer */}
      <SidebarFooter className="border-t border-white/[0.08] p-2">
        <SidebarMenu>
          <SidebarMenuItem>
            <DropdownMenu>
              <DropdownMenuTrigger asChild>
                <SidebarMenuButton
                  className="h-9 rounded-md px-2 text-[13px] text-[#8a8f98] hover:bg-white/[0.04] hover:text-[#d0d6e0]"
                  tooltip="Account"
                  style={{ fontFeatureSettings: '"cv01", "ss03"' }}
                >
                  <Avatar className="h-5 w-5 shrink-0 rounded-md">
                    <AvatarFallback className="rounded-md bg-[#5e6ad2]/20 text-[9px] font-[590] text-[#7170ff]">
                      {initials}
                    </AvatarFallback>
                  </Avatar>
                  <div className="flex min-w-0 flex-1 flex-col group-data-[collapsible=icon]:hidden">
                    <span className="truncate text-[12px] font-[510] text-[#d0d6e0]">
                      {displayEmail.split('@')[0]}
                    </span>
                    <span className="truncate text-[11px] text-[#62666d]">{displayEmail}</span>
                  </div>
                  <ChevronsUpDown className="ml-auto h-3.5 w-3.5 shrink-0 group-data-[collapsible=icon]:hidden" />
                </SidebarMenuButton>
              </DropdownMenuTrigger>
              <DropdownMenuContent
                side="top"
                align="start"
                className="w-56 rounded-lg border border-white/[0.08] bg-[#191a1b] text-[#d0d6e0]"
              >
                <div className="px-2 py-1.5">
                  <p className="text-[12px] font-[510] text-[#f7f8f8]">{displayEmail.split('@')[0]}</p>
                  <p className="text-[11px] text-[#62666d]">{displayEmail}</p>
                </div>
                <DropdownMenuSeparator className="bg-white/[0.08]" />
                <DropdownMenuItem
                  onClick={logout}
                  className="cursor-pointer gap-2 text-[13px] text-[#8a8f98] hover:text-[#f7f8f8] focus:bg-white/[0.05] focus:text-[#f7f8f8]"
                >
                  <LogOut className="h-3.5 w-3.5" />
                  Sign out
                </DropdownMenuItem>
              </DropdownMenuContent>
            </DropdownMenu>
          </SidebarMenuItem>
        </SidebarMenu>
      </SidebarFooter>
    </Sidebar>
  )
}
