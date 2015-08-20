//
//  YouTubeLive.swift
//  OverRustleiOS
//
//  Created by Hayk Saakian on 8/19/15.
//  Copyright (c) 2015 Maxwell Burggraf. All rights reserved.
//

import Foundation

public class YouTubeLive: RustleStream {
    
    let STATUS_ENDPOINT = "http://youtube.com/get_video_info?el=player_embedded&video_id=%@";
    
    override func getStreamURL() -> NSURL {
        let status_url_string = String(format: STATUS_ENDPOINT, channel)
        
        var qualitiesURL = NSURL(string:status_url_string.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)
        
        var error : NSError?
        var qualitiesNSString = NSString(contentsOfURL: qualitiesURL!, encoding: NSUTF8StringEncoding, error: &error)
        
        var list = qualitiesNSString!.componentsSeparatedByString("&")
        
        var url = NSURL()
        
        for line in list {
            if !line.hasPrefix("hlsvp") {
                continue
            }
            let encoded_url_string = line.componentsSeparatedByString("=")[1] as! String
            let decoded_url_string = encoded_url_string.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
            url = NSURL(string: decoded_url_string)!
            break
        }
        return url
    }
    
    
}