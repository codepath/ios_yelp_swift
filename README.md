### Basic Yelp client

This is a headless example of how to implement an OAuth 1.0a Yelp API client. The Yelp API provides an application token that allows applications to make unauthenticated requests to their search API.

### Next steps

- Check out `MainViewController.swift` to see how to use the `YelpClient`.
- Augment the search method in the `YelpClient` with whatever search parameters you want to support.

### Sample request

```
client = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)

client.searchWithTerm("Thai", success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
    println(response)
}) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
    println(error)
}

```

### Sample response

```
{
    businesses =     (
        {
            categories =             (
                                (
                    Laotian,
                    laotian
                ),
                                (
                    Thai,
                    thai
                )
            );
            "display_phone" = "+1-415-796-3391";
            distance = "789.6398263647031";
            id = "tycoon-thai-restaurant-san-francisco";
            "image_url" = "http://s3-media1.fl.yelpassets.com/bphoto/0ygpM52ux-e8YrMEdFUEcA/ms.jpg";
            "is_claimed" = 1;
            "is_closed" = 0;
            location =             {
                address =                 (
                    "620 O'Farrell St"
                );
                city = "San Francisco";
                coordinate =                 {
                    latitude = "37.78563851356";
                    longitude = "-122.415149049807";
                };
                "country_code" = US;
                "cross_streets" = "Harlem Aly & Leavenworth St";
                "display_address" =                 (
                    "620 O'Farrell St",
                    Tenderloin,
                    "San Francisco, CA 94109"
                );
                "geo_accuracy" = "9.5";
                neighborhoods =                 (
                    Tenderloin
                );
                "postal_code" = 94109;
                "state_code" = CA;
            };
            "mobile_url" = "http://m.yelp.com/biz/tycoon-thai-restaurant-san-francisco";
            name = "Tycoon Thai Restaurant";
            phone = 4157963391;
            rating = "4.5";
            "rating_img_url" = "http://s3-media2.fl.yelpassets.com/assets/2/www/img/99493c12711e/ico/stars/v1/stars_4_half.png";
            "rating_img_url_large" = "http://s3-media4.fl.yelpassets.com/assets/2/www/img/9f83790ff7f6/ico/stars/v1/stars_large_4_half.png";
            "rating_img_url_small" = "http://s3-media2.fl.yelpassets.com/assets/2/www/img/a5221e66bc70/ico/stars/v1/stars_small_4_half.png";
            "review_count" = 59;
            "snippet_image_url" = "http://s3-media1.fl.yelpassets.com/photo/L9aadSdOmgkUSOc1BfsLKw/ms.jpg";
            "snippet_text" = "OMG! Amaaaaazzzzing food! :) I came here the first time with my co-workers, and then came again with one of my friends. We were so impressed by the homey...";
            url = "http://www.yelp.com/biz/tycoon-thai-restaurant-san-francisco";
        }
    )
}
```

