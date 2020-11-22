//
//  Pokemon.swift
//  o_pokedekk
//
//  Created by Pasquale Spisto on 16/11/20.
//

import Foundation

import Foundation

// MARK: - Pokemon
struct Pokemon: Codable {
   let id:                       Int?
   let name:                     String?
   let baseExperience:           Int?
   let height:                   Int?
   let isDefault:                Bool?
   let order, weight:            Int?
   let abilities:                [Ability]?
   let forms:                    [Species]?
   let gameIndices:              [GameIndex]?
   let heldItems:                [HeldItem]?
   let locationAreaEncounters:   String?
   let moves:                    [Move]?
   let species:                  Species?
   let sprites:                  Sprites?
   let stats:                    [Stat]?
   let types:                    [TypeElement]?
   
   enum CodingKeys: String, CodingKey {
      case id, name
      case baseExperience = "base_experience"
      case height
      case isDefault = "is_default"
      case order, weight, abilities, forms
      case gameIndices = "game_indices"
      case heldItems = "held_items"
      case locationAreaEncounters = "location_area_encounters"
      case moves, species, sprites, stats, types
   }
}

// MARK: - Ability
struct Ability: Codable {
   let isHidden: Bool?
   let slot: Int?
   let ability: Species?
   
   enum CodingKeys: String, CodingKey {
      case isHidden = "is_hidden"
      case slot, ability
   }
}

// MARK: - Species
struct Species: Codable {
   let name: String?
   let url: String?
}

// MARK: - GameIndex
struct GameIndex: Codable {
   let gameIndex: Int?
   let version: Species?
   
   enum CodingKeys: String, CodingKey {
      case gameIndex = "game_index"
      case version
   }
}

// MARK: - HeldItem
struct HeldItem: Codable {
   let item: Species?
   let versionDetails: [VersionDetail]?
   
   enum CodingKeys: String, CodingKey {
      case item
      case versionDetails = "version_details"
   }
}

// MARK: - VersionDetail
struct VersionDetail: Codable {
   let rarity: Int?
   let version: Species?
}

// MARK: - Move
struct Move: Codable {
   let move: Species?
   let versionGroupDetails: [VersionGroupDetail]?
   
   enum CodingKeys: String, CodingKey {
      case move
      case versionGroupDetails = "version_group_details"
   }
}

// MARK: - VersionGroupDetail
struct VersionGroupDetail: Codable {
   let levelLearnedAt: Int?
   let versionGroup, moveLearnMethod: Species?
   
   enum CodingKeys: String, CodingKey {
      case levelLearnedAt = "level_learned_at"
      case versionGroup = "version_group"
      case moveLearnMethod = "move_learn_method"
   }
}

// MARK: - Sprites
struct Sprites: Codable {
   let backFemale, backShinyFemale, backDefault, frontFemale: String?
   let frontShinyFemale, backShiny, frontDefault, frontShiny: String?
   let other: Other?
   let versions: Versions?
   
   enum CodingKeys: String, CodingKey {
      case backFemale = "back_female"
      case backShinyFemale = "back_shiny_female"
      case backDefault = "back_default"
      case frontFemale = "front_female"
      case frontShinyFemale = "front_shiny_female"
      case backShiny = "back_shiny"
      case frontDefault = "front_default"
      case frontShiny = "front_shiny"
      case other, versions
   }
}

// MARK: - Other
struct Other: Codable {
   let dreamWorld, officialArtwork: DreamWorld?
   
   enum CodingKeys: String, CodingKey {
      case dreamWorld = "dream_world"
      case officialArtwork = "official-artwork"
   }
}

// MARK: - DreamWorld
struct DreamWorld: Codable {
}

// MARK: - Versions
struct Versions: Codable {
   let generationI: GenerationI?
   let generationIi: GenerationIi?
   let generationIii: GenerationIii?
   let generationIv: GenerationIv?
   let generationV: GenerationV?
   let generationVi: [String: DreamWorld]?
   let generationVii: GenerationVii?
   let generationViii: GenerationViii?
   
   enum CodingKeys: String, CodingKey {
      case generationI = "generation-i"
      case generationIi = "generation-ii"
      case generationIii = "generation-iii"
      case generationIv = "generation-iv"
      case generationV = "generation-v"
      case generationVi = "generation-vi"
      case generationVii = "generation-vii"
      case generationViii = "generation-viii"
   }
}

// MARK: - GenerationI
struct GenerationI: Codable {
   let redBlue, yellow: DreamWorld?
   
   enum CodingKeys: String, CodingKey {
      case redBlue = "red-blue"
      case yellow
   }
}

// MARK: - GenerationIi
struct GenerationIi: Codable {
   let crystal, gold, silver: DreamWorld?
}

// MARK: - GenerationIii
struct GenerationIii: Codable {
   let emerald, fireredLeafgreen, rubySapphire: DreamWorld?
   
   enum CodingKeys: String, CodingKey {
      case emerald
      case fireredLeafgreen = "firered-leafgreen"
      case rubySapphire = "ruby-sapphire"
   }
}

// MARK: - GenerationIv
struct GenerationIv: Codable {
   let diamondPearl, heartgoldSoulsilver, platinum: DreamWorld?
   
   enum CodingKeys: String, CodingKey {
      case diamondPearl = "diamond-pearl"
      case heartgoldSoulsilver = "heartgold-soulsilver"
      case platinum
   }
}

// MARK: - GenerationV
struct GenerationV: Codable {
   let blackWhite: DreamWorld?
   
   enum CodingKeys: String, CodingKey {
      case blackWhite = "black-white"
   }
}

// MARK: - GenerationVii
struct GenerationVii: Codable {
   let icons, ultraSunUltraMoon: DreamWorld?
   
   enum CodingKeys: String, CodingKey {
      case icons
      case ultraSunUltraMoon = "ultra-sun-ultra-moon"
   }
}

// MARK: - GenerationViii
struct GenerationViii: Codable {
   let icons: DreamWorld?
}

// MARK: - Stat
struct Stat: Codable {
   let baseStat, effort: Int?
   let stat: Species?
   
   enum CodingKeys: String, CodingKey {
      case baseStat = "base_stat"
      case effort, stat
   }
}

// MARK: - TypeElement
struct TypeElement: Codable {
   let slot: Int?
   let type: Species?
}
