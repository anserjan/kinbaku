SolidusContentBlocks
====================

Add Content Blocks to solidus_static_content(which are actually pages).
Content Blocks could be ordered by the user.

Each Content Block has a content_type which can be for now

* Text (Rich Text)
* Gallery (orderable)
* Text two Columns
* Text three Columns
* Text four Columns
* Text six Columns
* Text Column and Gallery Column (with different column partitions)
* Embed
* Product Preview (Select Product)
* Taxon Preview (Select Taxon)

Does not add anything to the Frontend view.

Installation
------------

```shell
bundle
bundle exec rails g solidus_content_blocks:install
```
