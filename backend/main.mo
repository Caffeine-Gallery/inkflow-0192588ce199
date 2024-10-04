import Func "mo:base/Func";
import Int "mo:base/Int";
import Nat "mo:base/Nat";

import Array "mo:base/Array";
import Time "mo:base/Time";
import Text "mo:base/Text";

actor {
  type Post = {
    id: Nat;
    title: Text;
    body: Text;
    author: Text;
    timestamp: Int;
    image: ?Text;
  };

  stable var posts : [Post] = [
    {
      id = 0;
      title = "The Internet Computer is a Beautiful Project";
      body = "The Internet Computer is a beautiful project and a game-changing public network that is reinventing compute on blockchain. The network now incorporates more than 1000 person-years of R&D. There is nothing else like it on earth.\n\nIf you want to understand why it will succeed in its mission, and succed big, this article outlines 10 key reasons why.\n\nThis post is part of a bigger post — Red Pill, Blue Pill — The Hidden History Of The Internet Computer, And Why It Will Win.\n\nEssential technical background can be obtained by quickly reading through sections 1, 2 and 8 in the preceding sub-post \"The History of The Internet Computer In 10 Steps.\"\n\nEvery section is preceded by a TL;DR section designed to give you the low down in a few words for those that wish to scan through quickly.\n\nInternet Computer Tech Is Years Ahead\nThird Generation Blockchain Functionality\nTrustless World Computer Multi-chain\nAI Models Will Run As Smart Contracts\n3rd Generation DAOs and \"Open Internet Services\"\nThe Foundations Of A DeFi 2.0 Ecosystem\n\"Cost Per Acquisition\" Can Beat Flywheels\nICP hubs, Web2 Developers, and Tiger Economies\nThe UTOPIA Project/The New Growth Engine\nInternet Computer Culture";
      author = "DFINITY";
      timestamp = Time.now();
      image = ?"https://miro.medium.com/v2/resize:fit:1400/format:webp/1*BYOmm-IJW2Dg8v1UiLAlfA.jpeg";
    }
  ];
  stable var nextId : Nat = 1;

  public func createPost(title: Text, body: Text, author: Text, image: ?Text) : async Nat {
    let post : Post = {
      id = nextId;
      title = title;
      body = body;
      author = author;
      timestamp = Time.now();
      image = image;
    };
    posts := Array.append(posts, [post]);
    nextId += 1;
    nextId - 1
  };

  public query func getPosts() : async [Post] {
    Array.reverse(posts)
  };
}
