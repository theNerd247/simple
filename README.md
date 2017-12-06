# simple

A simple web framework wrapper for writing simple API endpoints. 

Non-Goals
---

  - routing. Use your webframework's routing system.
  - http method filtering. If your webframework doesn't provide this then you
    might have a bigger issue on hand.
  - serializing. Provide your own parsers. We use lazy Bytestrings as the type
    to parse from. 

Out of the box support 
---
  - snap. Personally this is what I use as my webframework so I support it
    natively. Import simple-snap

  - Since JSON is so common we provide simple-aeson to give out
    of the box support for types that serialize to and from aeson.
