//
//  main.m
//  VowelMovement
//
//  Created by Daniel Buckle on 22/04/2013.
//  Copyright (c) 2013 Daniel Buckle. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ArrayEnumerationBlock)(id, NSUInteger, BOOL *);

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        // Create the array of strings to devowlize and a container for new ones
        NSArray *oldStrings = [NSArray arrayWithObjects:@"Sauerkraut", @"Raygun", @"Big Nerd Ranch",
                               @"Mississippi", nil];
        NSLog(@"old strings: %@", oldStrings);
        NSMutableArray *newStrings = [NSMutableArray array];
        
        NSArray *vowels = [NSArray arrayWithObjects:@"a", @"e", @"i", @"o", @"u", nil];
        
        // Iterate over the strings removing the vowels. Encapsulate the entire
        // block within the angled brackets: error 1 solved. Use the enumerateObjectsUsingBlock
        // to pass the block anonymously to the oldStrings array. Enumerate over the array while using
        // the block.
        [oldStrings enumerateObjectsUsingBlock:^(id string, NSUInteger i, BOOL *stop){
            
            NSRange yRange = [string rangeOfString:@"y"
                                           options:NSCaseInsensitiveSearch];
            
            // Did I find a y??
            if (yRange.location != NSNotFound) {
                *stop = YES; // Prevent further iterations
                return; // Stop the iteration
            }
            
            NSMutableString *newString = [NSMutableString stringWithString:string];
            
            // Iterate over the array of vowels, replacing occurences of each
            // with an empty string
            for (NSString *s in vowels) {
                NSRange fullRange = NSMakeRange(0, [newString length]);
                [newString replaceOccurrencesOfString:s withString:@"" options:NSCaseInsensitiveSearch
                                                range:fullRange];
            }
            
            [newStrings addObject:newString];
        }]; // End block statement
        
        // Print the new strings
        NSLog(@"new strings: %@", newStrings);
    }
    return 0;
}

