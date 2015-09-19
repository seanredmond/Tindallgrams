---
layout: inner
title: Contribute
---

## How To Contribute

All files for this website are hosted on [Github](https://github.com/seanredmond/Tindallgrams/). Contributions and corrections can be submitted there.

### Typos

If you find a typo or any error, you can correct it yourself by making a pull request (see below), or [create an issue](https://github.com/seanredmond/Tindallgrams/issues) of Github

### Editing Tindallgrams

The biggest task by far is editing the Tindallgrams themselves. To contribute in this way, first find a Tindallgram that needs to be edited in one of the [sources](/source/). Fork [the repository](https://github.com/seanredmond/Tindallgrams/), add your edited text and issue a pull request. You can find many guides to this workflow on the internet.

Every Tindallgram should be in a Markdown file with the extension `.md` and a name exactly matching (including case) the "serial" of the Tindallgram. For example, the text of "66-FM1-100" would go in a file named `66-FM1-100.md`.

Each file needs some [Jekyll front matter](http://jekyllrb.com/docs/frontmatter/), including at least `layout`, `date`, `from`, `serial` and `subject`. `layout` for all Tindallgrams must be `tindallgram` (some other kinds of pages have different layouts). These other minimally required values come from the memos themselves. Again using 66-FM1-100 as an example:

    ---
    layout: tindallgram
    date: Aug 30 1966 
    from: FM/Deputy Chief, Mission Planning and Analysis Division
    serial: 66-FM1-100
    subject: Notes regarding the AS-207/208 Guidance Systems Operation Plan (GSOP) meeting with MIT
    ---

The body of the Tindallgram should then follow, in [Markdown](http://daringfireball.net/projects/markdown/) format, though very little formatting is required beyond blank lines between paragraphs.

#### Line breaks

Put line breaks where they occur in the original. This will not be reflected in the online versions, but at least the markdown files will reflect the originals in this way if that ever becomes important to somebody. When a word is hyphenated at the end of a line, remove the hyphen, recombine the word and place a line break after.

#### Signatures, handwritten notes, and adressees

Do not include Tindall's signature or the sometimes included lists of addressees. Do not include indications of handwritten notes.

#### "Non-Tindall" material

A few memos by other people or attachments are included in the PDFs. Do not transcribe these. There is some interest in providing links in the edited Tindallgrams to the PDF sources. If this feature were added [see Issue #4](https://github.com/seanredmond/Tindallgrams/issues/4), perhaps we could provide an annotation in the transcribed version to see the attached material there.

## Running a local copy

Since this uses [Jekyll](http://jekyllrb.com/) you will need ruby. To run a version on localhost:

    $ bundle install
    $ bundle exec jekyll build
	$ bundle exec jekyll serve

You can then visit http://localhost:4000/ to view. _There is one caveat_: when running locally, you have to add `.html` to all URLs except for the index. For example the equivalent of `http://tindallgrams.net/66-FM1-59` on localhost has to be `http://localhost:4000/66-FM1-59.html`. This is annoying, so if anyone wants to take on [Issue #20](https://github.com/seanredmond/Tindallgrams/issues/20), that would be awesome.
