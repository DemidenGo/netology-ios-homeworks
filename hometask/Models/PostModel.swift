//
//  PostModel.swift
//  hometask
//
//  Created by Юрий Демиденко on 26.04.2022.
//

import UIKit

struct PostModel {

    let author: String
    let title: String
    let description: String
    let image: String
    let likes: Int
    let views: Int

    static func makeMockModel() -> [PostModel] {

        var model = [PostModel]()

        model.append(PostModel(author: "Homer Simpson",
                               title: "Woo-Hoo!",
                               description: "This is quote that has become part of our daily conversations. It's Homer's version of elation. Where 'Hmmm ...' represents his love of food, 'Woo-Hoo!' comes out when the news is surprisingly happy. It's also used in conjunction with 'D'oh!' in a good news-bad news situation. In other words, it's a quote with multiple uses.",
                               image: "Homer-WooHoo",
                               likes: 125,
                               views: 144))

        model.append(PostModel(author: "Marge Simpson",
                               title: "I've Got A Problem.",
                               description: "As Soon As You Stop This Car, I'm Gonna Hug You, And Kiss You, And Then I'll Never Be Able To Let You Go! Through all the ups and downs, Homer and Marge always find a way to make their relationship work. The episode 'The Way We Was', features Homer and Marge telling the story about how they first met to their kids. After they both have a terrible experience during their high school prom, Marge picks up Homer on the side of the road.",
                               image: "Homer-Simpson-Marge",
                               likes: 89,
                               views: 112))

        model.append(PostModel(author: "Bart Simpson",
                               title: "Why You Little ...",
                               description: "Though he doesn't choke Bart as much as he used to, this is an example of a Homer saying that has become part of our own language. It's also one of the signs he's really angry. If you think about it, Homer is a calm person. He gets riled up once in a while. Or, he channels his anger into rage. As he has never found himself in a physical altercation with any other member of his family, it seems Bart is his outlet.",
                               image: "Homer-Why-You-Little",
                               likes: 56,
                               views: 89))

        model.append(PostModel(author: "Lisa Simpson",
                               title: "Saxamaphone. Saxamaphone.",
                               description: "Homer loves his children. It may not seem like it, but he has had some fine moments with them over the last three decades. Unfortunately, it takes a downfall to make him realize what he's missed. When Lisa, Bart, and Maggie were taken away by Child Protective Services, we saw this compassion. He misses Lisa so much that he pretends to play her saxamaphone. It's a cute and defining moment.",
                               image: "Homer-Saxamaphone",
                               likes: 103,
                               views: 147))

        model.append(PostModel(author: "Homer Simpson",
                               title: "To Alcohol! The Cause Of, And Solution To, All Of Life's Problems.",
                               description: "This quote was mentioned at the end of 'Homer vs the Eighteenth Amendment', and since then it's left a lasting impression. Parodying the series The Untouchables, the episode focuses on the town prohibiting alcohol after Bart gets intoxicated during a St. Patricks Day celebration. After the prohibition is lifted and the whole town celebrates, Homer uses the quote to close the episode. This quote is famous not just because it addresses the reality behind alcohol consumption, it also reflects an important aspect of Homer’s personality. The episode's showrunner Josh Weinstein commented that the quote is one of the best and most truthful statements in the series.",
                               image: "Homer-Simpson-Alcohol",
                               likes: 235,
                               views: 340))

        return model
    }
}
