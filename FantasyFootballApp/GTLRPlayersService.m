// NOTE: This file was generated by the ServiceGenerator.

// ----------------------------------------------------------------------------
// API:
//   players/v2
// Description:
//   API for NFL Players

#import "GTLRPlayers.h"

// ----------------------------------------------------------------------------
// Authorization scope

NSString * const kGTLRAuthScopePlayersUserinfoEmail = @"https://www.googleapis.com/auth/userinfo.email";

// ----------------------------------------------------------------------------
//   GTLRPlayersService
//

@implementation GTLRPlayersService

- (instancetype)init {
  self = [super init];
  if (self) {
    // From discovery.
    self.rootURLString = @"https://cs496-ryanjones-osu.appspot.com/_ah/api/";
    self.servicePath = @"players/v2/";
    self.batchPath = @"batch";
    self.prettyPrintQueryParameterNames = @[ @"prettyPrint" ];
  }
  return self;
}

@end