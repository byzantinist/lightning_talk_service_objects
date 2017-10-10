I. What are Service Objects?

Service objects decompose fat ActiveRecord models and help keep controllers slim and readable.

Unlike the “fat model” style where a small number of objects contain many, many methods for the necessary logic, service objects result in many classes, each of which is single-purpose. This is where you place the business logic or business process.

In Rails, “model” refers to “a class that extends ActiveRecord::Base”



II. Why use Service Objects?

A. Design Logic
B. Simplicity and Easier to Understand Models
C. Better Performance
D. Pass Testing

Models should actually reflect the business objects related but these service objects may help complete an action (e.g. create_invoice or register_user).

Use when:

- Need to define complex actions
- Processes with many steps
- Callbacks
- Interactions with multiple models

Problem with avoiding callbacks (actions performed before, after, or around ActiveRecord events like save, validate, or create).

Developers notice these issues during testing as the application grows and more logic is required. During testing, developers want to speed up tests or get them to pass. They may need to “stub out” callback actions or add supporting data structures, classes, or logic.

In example_callback_stubbing, notify_followers must be “stubbed out” or it will fail because it will not be able to execute the delivery (due to nil values)



III. How do you use Service Objects?

Rails does not create a services folder by default so you will need to create one within the app folder.

Reload your rails servers since Rails will autoload directories in the app directory.

There are no universal standards or conventions, but here are some sample suggestions to give you an idea

1. Do not store state
2. Use instance methods, not class methods
3. There should be very few public methods
4. Method parameters should be value objects, either to be operated on or needed as input
5. Methods should return rich result objects and not booleans
6. Dependent service objects should b accessible via private methods and created in the constructor

1. Stick to one naming convention
  UserCreator, TwitterAuthenticator, CodeObfuscator
  CreateUser, AuthenticateUsingTwitter, ObfuscateCode
2. Do not instantiate service objects directly (see example)
  3. Stick to one way of calling service objects
  call, perform, run, execute
  4. One responsibility per service object
  5. Keep constructors simple
  6. Keep the arguments of call methods simple
7. Return results through state reader
  Returning true/false versus the actual service object itself (latter lets you take advantage of reading service object instance state)
  8. Focus on readability of the call method
  9. Consider wrapping call methods in transactions
10. Group service objects in namespaces
