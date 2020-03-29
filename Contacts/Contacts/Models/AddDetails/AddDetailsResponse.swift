
import Foundation
struct AddDetailsResponse : Codable {
	let id : Int?
	let first_name : String?
	let last_name : String?
	let email : String?
	let phone_number : String?
	let profile_pic : String?
	let favorite : Bool?
	let created_at : String?
	let updated_at : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case first_name = "first_name"
		case last_name = "last_name"
		case email = "email"
		case phone_number = "phone_number"
		case profile_pic = "profile_pic"
		case favorite = "favorite"
		case created_at = "created_at"
		case updated_at = "updated_at"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
		last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
		email = try values.decodeIfPresent(String.self, forKey: .email)
		phone_number = try values.decodeIfPresent(String.self, forKey: .phone_number)
		profile_pic = try values.decodeIfPresent(String.self, forKey: .profile_pic)
		favorite = try values.decodeIfPresent(Bool.self, forKey: .favorite)
		created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
		updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
	}

}
