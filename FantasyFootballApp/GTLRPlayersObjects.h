// NOTE: This file was generated by the ServiceGenerator.

// ----------------------------------------------------------------------------
// API:
//   players/v2
// Description:
//   API for NFL Players

#if GTLR_BUILT_AS_FRAMEWORK
  #import "GTLR/GTLRObject.h"
#else
  #import "GTLRObject.h"
#endif

#if GTLR_RUNTIME_VERSION != 3000
#error This file was generated by a different version of ServiceGenerator which is incompatible with this GTLR library source.
#endif

@class GTLRPlayers_MainAPIPlayer;

NS_ASSUME_NONNULL_BEGIN

/**
 *  GTLRPlayers_MainAPIPlayer
 */
@interface GTLRPlayers_MainAPIPlayer : GTLRObject

@property(nonatomic, copy, nullable) NSString *name;
@property(nonatomic, copy, nullable) NSString *position;

@end


/**
 *  GTLRPlayers_MainAPIPlayerList
 */
@interface GTLRPlayers_MainAPIPlayerList : GTLRObject

@property(nonatomic, strong, nullable) NSArray<GTLRPlayers_MainAPIPlayer *> *players;

@end

NS_ASSUME_NONNULL_END