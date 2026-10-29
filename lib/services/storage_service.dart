/// Save data model per TDD Section 10.
class PlayerSaveData {
  const PlayerSaveData({
    this.currentLevel = 1,
    this.highestUnlockedLevel = 1,
    this.coins = 150,
    this.extraSlotBoosters = 2,
    this.magnetBoosters = 2,
    this.smashBoosters = 1,
    this.levelStars = const <int, int>{},
    this.sfxEnabled = true,
    this.musicEnabled = true,
    this.hapticsEnabled = true,
    this.colourblindMode = false,
  });

  final int currentLevel;
  final int highestUnlockedLevel;
  final int coins;
  final int extraSlotBoosters;
  final int magnetBoosters;
  final int smashBoosters;
  final Map<int, int> levelStars;
  final bool sfxEnabled;
  final bool musicEnabled;
  final bool hapticsEnabled;
  final bool colourblindMode;

  PlayerSaveData copyWith({
    int? currentLevel,
    int? highestUnlockedLevel,
    int? coins,
    int? extraSlotBoosters,
    int? magnetBoosters,
    int? smashBoosters,
    Map<int, int>? levelStars,
    bool? sfxEnabled,
    bool? musicEnabled,
    bool? hapticsEnabled,
    bool? colourblindMode,
  }) {
    return PlayerSaveData(
      currentLevel: currentLevel ?? this.currentLevel,
      highestUnlockedLevel: highestUnlockedLevel ?? this.highestUnlockedLevel,
      coins: coins ?? this.coins,
      extraSlotBoosters: extraSlotBoosters ?? this.extraSlotBoosters,
      magnetBoosters: magnetBoosters ?? this.magnetBoosters,
      smashBoosters: smashBoosters ?? this.smashBoosters,
      levelStars: levelStars ?? this.levelStars,
      sfxEnabled: sfxEnabled ?? this.sfxEnabled,
      musicEnabled: musicEnabled ?? this.musicEnabled,
      hapticsEnabled: hapticsEnabled ?? this.hapticsEnabled,
      colourblindMode: colourblindMode ?? this.colourblindMode,
    );
  }

  Map<String, dynamic> toJson() => {
        'currentLevel': currentLevel,
        'highestUnlockedLevel': highestUnlockedLevel,
        'coins': coins,
        'extraSlotBoosters': extraSlotBoosters,
        'magnetBoosters': magnetBoosters,
        'smashBoosters': smashBoosters,
        'levelStars': levelStars.map((k, v) => MapEntry(k.toString(), v)),
        'sfxEnabled': sfxEnabled,
        'musicEnabled': musicEnabled,
        'hapticsEnabled': hapticsEnabled,
        'colourblindMode': colourblindMode,
      };

  factory PlayerSaveData.fromJson(Map<String, dynamic> json) {
    final rawStars = json['levelStars'] as Map<String, dynamic>? ?? {};
    final parsedStars = <int, int>{};
    for (final e in rawStars.entries) {
      final key = int.tryParse(e.key);
      if (key != null && e.value is int) {
        parsedStars[key] = e.value as int;
      }
    }

    return PlayerSaveData(
      currentLevel: (json['currentLevel'] as num?)?.toInt() ?? 1,
      highestUnlockedLevel:
          (json['highestUnlockedLevel'] as num?)?.toInt() ?? 1,
      coins: (json['coins'] as num?)?.toInt() ?? 150,
      extraSlotBoosters: (json['extraSlotBoosters'] as num?)?.toInt() ?? 2,
      magnetBoosters: (json['magnetBoosters'] as num?)?.toInt() ?? 2,
      smashBoosters: (json['smashBoosters'] as num?)?.toInt() ?? 1,
      levelStars: parsedStars,
      sfxEnabled: json['sfxEnabled'] as bool? ?? true,
      musicEnabled: json['musicEnabled'] as bool? ?? true,
      hapticsEnabled: json['hapticsEnabled'] as bool? ?? true,
      colourblindMode: json['colourblindMode'] as bool? ?? false,
    );
  }
}

/// Abstract interface for loading and saving player state.
abstract class StorageService {
  Future<PlayerSaveData> loadSaveData();
  Future<void> saveSaveData(PlayerSaveData data);
}

/// In-memory storage implementation for quick boots and tests.
class InMemoryStorageService implements StorageService {
  InMemoryStorageService([PlayerSaveData? initial])
      : _data = initial ?? const PlayerSaveData();

  PlayerSaveData _data;

  @override
  Future<PlayerSaveData> loadSaveData() async => _data;

  @override
  Future<void> saveSaveData(PlayerSaveData data) async {
    _data = data;
  }
}
