import { SidebarInset, SidebarProvider, SidebarTrigger } from '@/components/ui/sidebar'
import { AppSidebar } from '@/components/app-sidebar'
import { Separator } from '@/components/ui/separator'

export default function DashboardLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <SidebarProvider>
      <AppSidebar />
      <SidebarInset>
        {/* Top bar */}
        <header className="flex h-11 shrink-0 items-center gap-2 border-b border-white/8 px-4">
          <SidebarTrigger className="-ml-1 h-7 w-7 text-[#8a8f98] hover:bg-white/5 hover:text-[#d0d6e0]" />
          <Separator orientation="vertical" className="mx-1 h-4 bg-white/8" />
        </header>
        <main className="flex flex-1 flex-col">
          {children}
        </main>
      </SidebarInset>
    </SidebarProvider>
  )
}
