
import Foundation
struct ContactsResponse : Codable {
	let id : Int?
	let first_name : String?
	let last_name : String?
	let profile_pic : String?
	let favorite : Bool?
	let url : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case first_name = "first_name"
		case last_name = "last_name"
		case profile_pic = "profile_pic"
		case favorite = "favorite"
		case url = "url"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
		last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
		profile_pic = try values.decodeIfPresent(String.self, forKey: .profile_pic)
		favorite = try values.decodeIfPresent(Bool.self, forKey: .favorite)
		url = try values.decodeIfPresent(String.self, forKey: .url)
	}

}
