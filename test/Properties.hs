module Main where

import qualified Codec.Archive.Tar.Index as Index
import qualified Codec.Archive.Tar.Index.IntTrie as IntTrie
import qualified Codec.Archive.Tar.Index.StringTable as StringTable

import Test.Tasty
import Test.Tasty.QuickCheck

main :: IO ()
main =
  defaultMain $
    testGroup "tar tests" [
      testGroup "string table" [
        testProperty "construction and lookup" StringTable.prop_valid
      ]
    , testGroup "int trie" [
        testProperty "unit 1"      IntTrie.test1,
        testProperty "unit 2"      IntTrie.test2,
        testProperty "unit 3"      IntTrie.test3,
        testProperty "lookups"     IntTrie.prop_lookup_mono,
        testProperty "completions" IntTrie.prop_completions_mono,
        testProperty "toList"      IntTrie.prop_construct_toList
      ]
    , testGroup "index" [
        testProperty "lookup"      Index.prop_lookup
      , testProperty "valid"       Index.prop_valid
      , testProperty "matches tar" Index.prop_index_matches_tar
      , testProperty "resume"      Index.prop_finalise_resume
      ]
    ]
