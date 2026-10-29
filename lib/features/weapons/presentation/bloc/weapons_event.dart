abstract class WeaponsEvent {
  const WeaponsEvent();
}

class FetchWeaponsEvent extends WeaponsEvent {
  const FetchWeaponsEvent();
}

class ToggleWeaponFavoriteEvent extends WeaponsEvent {
  final String weaponId;
  final bool isFavorite;
  const ToggleWeaponFavoriteEvent(this.weaponId, this.isFavorite);
}
