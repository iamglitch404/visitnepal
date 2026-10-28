part of 'mainScreen.dart';

extension MainScreenUIExtension on _MainScreenState {
  Widget _buildDesktopSidebar(ThemeData theme) {
    return Container(
      width: 250,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          right: BorderSide(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.06),
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/svg/logo.jpeg',
                    width: 32,
                    height: 32,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'VISIT NEPAL',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                    letterSpacing: 1.5,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          Expanded(
            child: ListView.builder(
              itemCount: _navItems.length,
              itemBuilder: (context, index) {
                final item = _navItems[index];
                final bool isSelected = _selectedIndex == index;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                  child: ListTile(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    selected: isSelected,
                    selectedTileColor: theme.colorScheme.primary.withValues(alpha: 0.1),
                    leading: Icon(
                      isSelected ? item['activeIcon'] : item['icon'],
                      color: isSelected ? theme.colorScheme.primary : theme.colorScheme.onSurface.withValues(alpha: 0.7),
                      size: 20,
                    ),
                    title: Text(
                      item['label'],
                      style: TextStyle(
                        fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
                        fontSize: 14,
                        color: isSelected ? theme.colorScheme.primary : theme.colorScheme.onSurface,
                      ),
                    ),
                    onTap: () => setState(() => _selectedIndex = index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabletNavigationRail(ThemeData theme) {
    return NavigationRail(
      backgroundColor: theme.colorScheme.surface,
      selectedIndex: _selectedIndex >= 5 ? 0 : _selectedIndex,
      onDestinationSelected: (index) => setState(() => _selectedIndex = index),
      labelType: NavigationRailLabelType.selected,
      leading: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.terrain_rounded, color: Colors.white, size: 20),
        ),
      ),
      destinations: _navItems.map((item) {
        return NavigationRailDestination(
          icon: Icon(item['icon']),
          selectedIcon: Icon(item['activeIcon'], color: theme.colorScheme.primary),
          label: Text(item['label']),
        );
      }).toList(),
    );
  }
}
