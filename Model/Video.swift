import Alamofire
import AVKit
import Foundation
import SwiftyJSON

struct Video: Identifiable, Equatable, Hashable {
    let id: String
    let videoID: String
    var title: String
    var thumbnails: [Thumbnail]
    var author: String
    var length: TimeInterval
    var published: String
    var views: Int
    var description: String?
    var genre: String?

    // index used when in the Playlist
    let indexID: String?

    var live: Bool
    var upcoming: Bool

    var streams = [Stream]()

    var publishedAt: Date?
    var likes: Int?
    var dislikes: Int?
    var keywords = [String]()

    var channel: Channel

    init(
        id: String? = nil,
        videoID: String,
        title: String,
        author: String,
        length: TimeInterval,
        published: String,
        views: Int,
        description: String? = nil,
        genre: String? = nil,
        channel: Channel,
        thumbnails: [Thumbnail] = [],
        indexID: String? = nil,
        live: Bool = false,
        upcoming: Bool = false,
        publishedAt: Date? = nil,
        likes: Int? = nil,
        dislikes: Int? = nil,
        keywords: [String] = [],
        streams: [Stream] = []
    ) {
        self.id = id ?? UUID().uuidString
        self.videoID = videoID
        self.title = title
        self.author = author
        self.length = length
        self.published = published
        self.views = views
        self.description = description
        self.genre = genre
        self.channel = channel
        self.thumbnails = thumbnails
        self.indexID = indexID
        self.live = live
        self.upcoming = upcoming
        self.publishedAt = publishedAt
        self.likes = likes
        self.dislikes = dislikes
        self.keywords = keywords
        self.streams = streams
    }

    var publishedDate: String? {
        (published.isEmpty || published == "0 seconds ago") ? nil : published
    }

    var viewsCount: String? {
        views != 0 ? views.formattedAsAbbreviation() : nil
    }

    var likesCount: String? {
        likes?.formattedAsAbbreviation()
    }

    var dislikesCount: String? {
        dislikes?.formattedAsAbbreviation()
    }

    func thumbnailURL(quality: Thumbnail.Quality) -> URL? {
        thumbnails.first { $0.quality == quality }?.url
    }

    static func == (lhs: Video, rhs: Video) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
