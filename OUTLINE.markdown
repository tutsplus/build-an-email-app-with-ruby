# Build an Email Application in Ruby

Ruby is much more than web development. In fact, it can do really great things
in your own system. If you agree, jump into the course to learn about some new
things on how to interact with email servers, with a focus on software
development practices and craftmanship.

# Introduction

## 01. Introduction

### Time: 00:03:15

Welcome to the course! In this lesson you'll be given an introduction to the
exercise we'll perform.

**Show notes**

- [Ruby Fundamentals
  course](courses.tutsplus.com/courses/the-fundamentals-of-ruby)
- [Design Patterns in
  Ruby](http://courses.tutsplus.com/courses/design-patterns-in-ruby)
- [Gang of Four Design Patterns in Ruby
  course](http://courses.tutsplus.com/courses/gang-of-four-design-patterns-in-ruby)

## 02. Bootstrap the Project

### Time: 00:11:03

We'll be building a publishable gem so it's important to get acquainted to the
structure of a typical gem. You'll learn how to set it up and customize it to
the specific needs of this project.

## 03. The Net::IMAP Library

### Time: 00:11:36

Before diving into specific feature code, you'll need to learn about the core
library to interact with email servers. You'll learn about `Net::IMAP` and the
minimal code setup to communicate with a server.

# Building our Features

## 04. Fetching Emails

### Time: 00:23:24

Now that you know a little bit about how to connect to an IMAP server, we'll
use that knowledge to create our abstractions. We'll write our first feature:
fetching actual emails and convert them to our own kind of objects.

## 05. Listing Folders with Emails

### Time: 00:19:43

Up until now we know how to fetch emails from one folder. In this lesson you'll
learn how to fetch all of the emails in your entire list of folders in your
email account.

## 06. Creating our First Integrated Task

### Time: 00:15:41

We've been creating isolated code through tests. Now is the time we integrate
it in the form of a console application and add the user into the equation.

## 07. Sending Email

### Time: 00:11:55

So far we've been reading emails. How about we send one? Let's create a feature
that sends an email through the `Net::SMTP` library.

## 08. Storing Email

### Time: 00:10:49

We'll assume that, when sending email, we store a copy in a specific folder.
We'll learn how to use the IMAP protocol to create that copy.

## 09. Reply to an Email

### Time: 00:14:11

Let's expand our codebase in order to add one more feature. Let's try and reply
to an existing email in our account. This will integrate the last two services
we've built: list emails and send a new one.

# Improvements

## 10. Extracting Configuration Data

### Time: 00:12:21

Most of our feature set is complete. There's one thing we'd like to do in order
to improve our user's experience: allow him to enter his own credentials. We
don't want the user to constantly export variables in the terminal so we'll
support the creation of one single, persistent file.

## 11. Setup a Bootstrap Task

### Time: 00:13:58

Continuing the process of setting up user's credentials, we'll provide him a
task to allow him to interactively build the information necessary to connect
to his server.

# Conclusion

## 12. Publishing the Gem

### Time: 00:05:33

Now that our gem is complete, let's make it publicly available. You'll learn
to publish the gem to Rubygems and to a private service like Gemfury. At the
end, we'll actually install the gem and use it as if it were in production.

## 13. Conclusion

### Time: 00:05:30

Thank you so much for taking the time in viewing this course. We hope you took
the principles applied in the exercise with you.

If you have feedback to give us about this course, feel free to reach us. See
you soon!

**Show notes**

- [Net::IMAP
  library](http://www.ruby-doc.org/stdlib-2.1.1/libdoc/net/imap/rdoc/Net/IMAP.html)
- [IMAP protocol reference](http://tools.ietf.org/html/rfc3501)
- [Gang of Four Design Patterns in Ruby
  course](http://courses.tutsplus.com/courses/gang-of-four-design-patterns-in-ruby)
- [Solid Design Patterns
  course](http://courses.tutsplus.com/courses/solid-design-patterns)
