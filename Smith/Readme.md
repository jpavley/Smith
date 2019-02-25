# UITableViewController Quick Start

## Overview

The UITableViewController object includes a controller for managing the table and a view for presenting the table. Tables are really lists of rows. Rows contains cells and cells contains views that display text, images, and anything else you can render on an iPhone screen. 

There are two styles of row presentation (plain and grouped) and two types of data sources (dynamic and static).
- _Grouped_ tables organize rows into visually seperated sections.
- _Plain_ tables have all rows in a single contiguous section.
- _Static_ tables get their row data from the storyboard. (Although you can work around this limitation.)
- _Dymatic_ tables get their row data from an object at runtime.

Sections are numbered from 0 to n, where n is the count of sections - 1. Rows are numbers from 0 to n, where n is the count of rows - 1. This means that it's easy to model the data for a table view as a two-dimentional array. Here's how to declare a 2D array of integers: 

```let arr = [[1,2,3],[4,5,6],[7,8,9]]```

The value for the 2nd row in the 1st section is found with:

```arr[0][1] // returns 2```

The number of sections is found with:

```arr.count // returns 3```

The number of rows in the 3rd sections is found with:

```arr[2].count```

In order to render data for the table the controller ask you through methods you have to override to supply the number sections, rows in each section, and a cell for a particular section/row. The key data structure to a table view controller uses to identify sections/rows values is the IndexPath.

```let indexPath = IndexPath(row: 1, section: 0)```

A UITableView is memory effcient and fast. You're not going to easily reproduct it's ecomonical footprint and performance so you should use UITableViews as much as possible. To keep memory constrained UITableViewCells are recycled using a pattern called dequeuing. Reusable cells are prototyped on a storyboard (or programmically in code) and associated with an ID so that you can use multiple cell prototypes as templates. 

Built into UITableViews are 4 cell presentation styles (Basic, Right Detail, Left Detail, and Subtitle). These cell styles include lables and image views that you can use to display content from your data model. It's not alway obvious what views are avaible but before you start creating a custom cell layouts see if one of the built-in styles will work. Less code, less bugs, and in this case, highly optimized performance.

To the right of a table view cell is an optional accessory view. An assessory is used to signal information about the table row object with icons that represent a checkmark, detail, detail disclosure, disclosure indicator, or nonthing. Tapping a row and tapping on it's accessory icon creates different events. You can use these events for multiple paths of navigationf or actions from the same row.

UITableViews rows respond to swiping left by revealing a delete button--if you add the special method to your UITableViewController to enable this behavoir. It's your responsbility to update the model in response to a deletion. 

UITableView allow single and multiple selections which then can be associted with actions. This way the user can delete or edit more than one row at a time.

UITableView rows respond to dragging up and down to rearrange the order of data represented by a table view. If this behavoir is enabled is's your responsiblity to update the model behind the table view.

The appearance of UITableViews can be completely customized with colors, fonts, images, and core graphics objects. Even your app has only one object on the screen a UITableView is probably the best way to present it for performacne and future modification (you might want to add a second object in the future).

Mastering the UITableViewController means learning almost allo the basics of iOS development including MVC, delegates, protocols, Navigation and segues, Swift programming, UIKit, and much of Xcode.

The only drawback to using a UITableViewController to present your app's data is that your app will look and feel like a typical iOS app. This is not really a drawback! It's a feature. Creating a rock solid app user experience is time consuming and harder than everyone thinks. It's not worth it.

## Application Part 1

Creating an iOS application with Xcode mains bouncing around between code files and the storyboard and its inspectors. Everyrthing can be done in code but storybords reduce the chance of errors and the amount of boilerplatcode. So get used to it!

### Project Setup

The following steps walking you through creating a simple app that can display a table.

1. Create a new iOS application with the _Single View Application_ template.
1. Delete the _View Controller Scene_ from the main storyboard.
1. In ViewController.swift set the class to inherit from _UITableViewController_ instead of _UIViewController_. You'll prbably want to give the ViewController class a more descriptive name, such as MainViewController.
1. Drag a _UITableViewController_ object on the main storyboard.
1. Attribute Inspector: Check the _Is Initial View Controller_ setting for the _UITableViewController_.
1. Identity Inspector: Set the _Custom Class_ type of the _UITableViewController_ to _MainViewController_ (or whatever you named your VC).
1. Document Outline: Select the _Table View Cell_ and in the Attributes Inspector set style to _Basic_ and identifier to "Cell1" or a unique string meaningful to your app.
1. Document Outline: Section the _Table View_ and in the Attributes Inspector set style to _Grouped_

Run the app and verify that you see an app with an empty table in the simulator.

### Code

The following steps include all the code for bringing your table to life. All coding takes place within the ViewController.swift file.

1. Add the _model_ property to the _ViewController_ class

````
import UIKit

class ViewController: UITableViewController {
    
    let model = [["cat","dog","cow"], ["village", "city", "town"], ["sun", "moon", "star"]]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}
````

1. Create an extention to the _ViewController_ class and override the _numberOfSections_, numberOfRowsInSection_, and _cellForRowAt_ data sources methods of _UITableViewController_

````
extension ViewController {
    
    // MARK:- Table View Data Source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return model.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath)
        cell.textLabel!.text = model[indexPath.section][indexPath.row]
        return cell
    }
}
````

### Test Run

Run the app and verify that you have a table view with three sections of three rows each.

While this app stub isn't very useful, it's the core of a _UITableViewController_-based iOS application. You have a simple model and you have overridden the methods required to display that model in a table view. The will will scroll and can accomodate hundreds, if not thousands of rows. (I have not tried thousands and that's probably not a great user expereince even if the app doesn't crash.)

You have linked _ViewController_ class the UITableViewController object in main storyboard with a reuable cell id and a custom class name.

## Application Part 2

### Cloud Atlas

But now let's make your app show details for each row item. 

First, we need a more interesting model. We'll create a custom class to represent this model and then use a navigation controller to display (segue to) a detail view (a static table view) with information from your model. It will be fun!

For your model let's say we're collecting clouds. There are many kinds of clouds, each with different properties, and we can use our app to help users identify the coulds above and, if they happend to flying, below them. Cloud formations have the following properties: Name, Abbreviation, Altitude range, ability to create precipitation, description.

### Cloud Model

Create a new swift file to contain the Cloud class:

````
import Foundation

enum CloudAltitude: Int {
    case low = 0, mid, high, count
}

class Cloud {
    var name = ""
    var abbreviation = ""
    var altitudeRange = [CloudAltitude]()
    var precipitationFlag = false
    var description = ""
}
````

Add a cloud factory to the _Cloud_ class:

````
static func cloudMaker(name: String,
                        abbreviation: String,
                        altitudeRange: [CloudAltitude],
                        precipitationFlog: Bool,
                        description: String) -> Cloud {
    
    let cloud = Cloud()
    cloud.name = name
    cloud.abbreviation = abbreviation
    cloud.altitudeRange = altitudeRange
    cloud.precipitationFlag = precipitationFlog
    cloud.description = description
    return cloud
}
````

Now it's time to enter in all the sample data for our cloud collection:

````
static func sampleData() -> [Cloud] {
    var clouds = [Cloud]()
    
    let cloud1 = cloudMaker(name: "Cumulonibmbus",
                            abbreviation: "Cb",
                            altitudeRange: [.low, .mid, .high],
                            precipitationFlog: true,
                            description: "verical sack of fluffy cotton balls with a dark bottom")
    clouds.append(cloud1)
    
    let cloud2 = cloudMaker(name: "Cumulus",
                            abbreviation: "Cu",
                            altitudeRange: [.low],
                            precipitationFlog: false,
                            description: "basket of fluffy cotton balls")
    clouds.append(cloud2)
    
    let cloud3 = cloudMaker(name: "Stratocumulus",
                            abbreviation: "Sc",
                            altitudeRange: [.low],
                            precipitationFlog: false,
                            description: "mountain range of fluffy cotton balls")
    clouds.append(cloud3)
    
    let cloud4 = cloudMaker(name: "Stratus",
                            abbreviation: "St",
                            altitudeRange: [.low],
                            precipitationFlog: false,
                            description: "tattered smears of thin cotton gauze")
    clouds.append(cloud4)
    
    let cloud5 = cloudMaker(name: "Nimbostratus",
                            abbreviation: "Ns",
                            altitudeRange: [.low, .mid],
                            precipitationFlog: true,
                            description: "dark and stormy wall of thunder")
    clouds.append(cloud5)
    
    let cloud6 = cloudMaker(name: "Altocumulus",
                            abbreviation: "Ac",
                            altitudeRange: [.mid],
                            precipitationFlog: false,
                            description: "Dumplings of white fluffy cotton")
    clouds.append(cloud6)
    
    let cloud7 = cloudMaker(name: "Altostratus",
                            abbreviation: "As",
                            altitudeRange: [.mid],
                            precipitationFlog: false,
                            description: "long smear of thick cotton gauze")
    clouds.append(cloud7)
    
    let cloud8 = cloudMaker(name: "Cirrocumulus",
                            abbreviation: "Cc",
                            altitudeRange: [.high],
                            precipitationFlog: false,
                            description: "little dots of white fluffy cotton")
    clouds.append(cloud8)
    
    let cloud9 = cloudMaker(name: "Cirrostratus",
                            abbreviation: "Cs",
                            altitudeRange: [.high],
                            precipitationFlog: false,
                            description: "long ribbons of thin cotton gauze")
    clouds.append(cloud9)

    let cloud0 = cloudMaker(name: "Cirrus",
                            abbreviation: "Ci",
                            altitudeRange: [.high],
                            precipitationFlog: false,
                            description: "ripped shreads thin cotton gauze")
    clouds.append(cloud0)
    
    return clouds
}
````

### Refactoring the Main View Controller

I know, it's a lot of typing, but it's worth it! Now we have a far more interesting model to work with. Let's update the _ViewController_ class to work with the cloud data.

````
import UIKit

class ViewController: UITableViewController {
    
    let model = Cloud.sampleData()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}

extension ViewController {
    
    // MARK:- Helpers
    
    fileprivate func sectionData(for section: Int) -> [Cloud]? {
        if let altitude = CloudAltitude(rawValue: section) {
            return model.filter {$0.altitudeRange.contains(altitude)}
        } else {
            return nil
        }
    }
    
    fileprivate func rowData(for indexPath: IndexPath) -> Cloud? {
        if let cloudData = sectionData(for: indexPath.section) {
            return cloudData[indexPath.row]
        } else {
            return nil
        }
    }
    
    // MARK:- Table View Data Source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        // We will have a section for each altitude (low, medium, and high)
        // Some clouds will appear more than once if they appear at multiple altitudes!
        
        return CloudAltitude.count.rawValue
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let cloudData = sectionData(for: section)
        return cloudData?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath)
        
        if let cloud = rowData(for: indexPath) {
            cell.textLabel!.text = cloud.name
        }
        
        return cell
    }
}
````

The array of Cloud objects is a bit more complicated than our previous model (a simple nested array of Ints). But with complexity comes a better user experience! We're mapping sections IDs (0, 1, 2) to altitude values using the raw values of the the enum _CloudAltitude_. The last case of _CloudAltitude_ (.last) is not an altitude but a trick to get the count of cases--which is the number of sections!

We use a couple of helper methods to get _section data_ based on altitude and _row data_ based on _IndexPath_. Becausde we could get a section or IndexPath beyond the amount of sample data we've entered we use optionals and nil values to keep everything in within legal ranges. Our helper methods help us keep the code in the tableView override methods concise. Concise is nice!

Concise note is so nice let's talk a little bit about how I achieved it and why. I'm using the _filter()_ method on the model object to create an array of cloud objects with the property I'm interested in for each section. I could have used a _for in_ loop but filter is just lone line of code and, after you get used to the abbrivated syntax that Swift provides for end-of-function closures, filter is much easier to read!

I'm going to all this work to achieve conciseness because more lines of code, means more potential bugs, less clarity of logic, and more code to maintain. (All of these things are the same thing: tech debt).

### Navigation Controller

Time to go back to the main storyboard and configure it to present a detail view of data for each cloud the user taps in the _ViewController_. We'll do this by indicating that more info is available for each row and linking to a new _UITableViewController_ to present that detail. While were at it we will give the sections headers so the user knows how the clouds are organized.

1. Select _Cell1_ in the _Document Outline_ and set it's _Accessory_ property in the _Attributes Inspector_ to _Discolure Indicator_. This places a gray arrow head on the right side each row that means "touch for more detail".
1. While _Cell1_ is still selected set _Selection_ to _None_ so the row doesn't turn gray when the user taps it.
1. Select the _View Controller Scene_ in the _Document Outline_ and use the _Embed In_ command from the _Editor Menu_ to place our table view controller inside a _Navigation Controller_. This gives us the UX to segue between view controllers!

Run the app and tell me what you see... not much new but we've created a view controller sandwich and have more properties we can set.

### Large Titles

Select the _View Controller's_ _Navigation Item_ and set it's _Title_ property to "Cloud Atlas." In modern iOS apps the title of a view controller should be huge! But we need to set this property in code as we only want the main view controller (Cloud Atlas) to have a huge title. Secondary view controllers should have regular-sized titles according to Apple.

````
override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    navigationController?.navigationBar.prefersLargeTitles = true
}
````

### Segue Between View Controllers

1. Drag a new _UITableViewController_ on to the main storyboard next to our original view controller.
1. Control drag from the _Cloud Atlas_ view controller (the orignal view controler) to the table view controller and create a segue with a show presentation.

If you run the app at this point an tap on a row--nothing will happen! The segue needs to be trigger manually! Add the code below to the ViewController.swift to execue the segue.

````
// MARK:- Navigation

override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    performSegue(withIdentifier: "ShowDetail", sender: nil)
}
````

Now you can verify that the segue is working by running the app and tapping a row. As a free feature from the navigation controller (that our table view controllers are sitting inside) we get a back button that enables the user to return to the Cloud Atlas view controller. But our detail view controller has no details.

### Cloud Details

Let's configure it as a static table view with fields for all the properties of clouds in our data model.

1. Select the table view in the new table view controller and set it's _Content_ property to _Static_ and it's _Style_ property to _grouped_.
1. Set the number of sections to 3. Xcode will give you 3 rows for each section. Set the number of rows for the 1st and 2nd sections to 2 and for the 3rd section to 1.
1. Select the _Table View Cells_ in each section and set all but the last one (of the last section) to _Style_ _Right Detail_. Xcode gives you a label on the left and a label on the right for each row.
1. For the row in the last section the _Style_ should be set to _Custom_. Drag and drop a _Text View_ into the row's _Content View_ and set its _Behavior_ properties to not _Editable_ and not _Selectable_. Set the following constraints on this _Text Area_: _Trailing, Leading, Bottom,_ and _Top_ space all to 6. Delete the default text and enter a single sentance to give you a feel for how the text will look inside the field at run time. The text will be clipped so change the row heigth by selecting the _TableView Cell_ of this section and in the _Size Inspector_ set the _Row Height_ to 72.
1. Select the left label of the 1st section, 1st row and set its text to "Name".
1. Select the left label of the 1st section, 2nd row and set its text to "Abbreviation".
1. Select the left label of the 2nd section, 1st row and set its text to "Altitude".
1. Select the left label of the 2nd section, 2nd row and set its text to "Precipatation".
1. Leave all the right labels in each row alone.
1. Selected the Table View Cell in each section and set _User Interaction Enabled_ to false.
1. As a final touch select the _View Controller Scene_ and change its _Title_ in the _Attributes Inspector_ to "Cloud Details".

Run the app, tap a row and see how wonderful your detail view is starting to look! Now we have to populate the _Cloud Details_ view controller with actual cloud data based on the user's tap and clean it up a bit with code. We can do a lot with story board settings but not everything! 

### Cloud Detail View Controller

First we need a class associated with the _Cloud Detail_ view controller to customize its behavior and present data from out model.

1. Create a new _Cocoa Touch_ class named "CloudDetailViewController" and base it on "UITableViewController".
1. Delete all the code that comes with this class (most of it is commented out) and replace it with the following much more simpler code:

````
import UIKit

class CloudDetailViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never

    }
}
````
Right now the only behavor we've added is to display a not-huge title with this view controller loads so we conform to Apple's Human Interface Guidelines.

Go to the storyboard and selecte the _Cloud Detail Scene_. Set its custom class to "CloudDetailViewController" in the _Identity Inspector_. This associates our new class with our new view controller.

### Wiring Up Outlets

We need to create properties in the _CloudDetailViewController_ that refere to the labels and text view on the _Cloud Detail Scene_ so that we can stuff the data for the selected cloud type into them. Add the following IBOutlets to _CloudDetailViewController.swift_:

````
@IBOutlet weak var nameLabel: UILabel!
@IBOutlet weak var abbreviationLabel: UILabel!
@IBOutlet weak var altitudeLabel: UILabel!
@IBOutlet weak var precipitationLabel: UILabel!
@IBOutlet weak var descriptionTextView: UITextView!
````

Next do the control drag thing between the circle next to each IBOutlet and the labels and text view on the storyboard. There are several ways to do this. My favorite is to control-drag from the yellow circle (that preferent a view controller's class) down to each storyboard object and select the cooresponding outlet from the pop-up menu that appears.

### Populating the Data

Now that we have the storyboard outlets connected to the _DetailViewController_ class we can finishing our project and display the details for any cloud tapped! 

We need to transfer the data for a particuar cloud from the _CloudAtlasViewController_ to the _DetailViewController_ and then we need to use that data to populate the labels and text view.

Let's start with the _CloudAtlasViewController_. Update the navigation code

````
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowDetail", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            let controller = segue.destination as! CloudDetailViewController
            let indexPath = sender as! IndexPath
            controller.model = rowData(for: indexPath)
        }
    }
````

Rember that when we tapped on a row we used the _tableView(didSelectRowAt:) method to call the _prepare(withIdentifier:sender)_ method. Here we are overriding the prepare with the segue we want to call and passing the IndexPath of that represets the section and row tapped. We set the _model_ varable of the destination of this segue to the cloud that has been chosen.

Almost done!

_CloudDetailViewController_ needs a variable called model to hold the data from _CloudAtlasViewController_:

````
var model: Cloud!
````

And _CloudDetailViewController_ needs to update it's views when it loads:

````
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        updateView()
    }
    
    func textFor(altitudeRange: [CloudAltitude]) -> String {
        var result = ""
        
        for altitude in altitudeRange {
            switch altitude {
            case .low:
                result += "Low "
            case .mid:
                result += "Mid "
            case .high:
                result += "High "
            case .count:
                result += "Count "
            }
        }
        
        return result
    }
    
    func updateView() {
        nameLabel.text = model.name
        abbreviationLabel.text = model.abbreviation
        descriptionTextView.text = model.description
        altitudeLabel.text = textFor(altitudeRange: model.altitudeRange)
        precipitationLabel.text = model.precipitationFlag ? "True" : "False"
    }
````

We have to convert the _Enum_ cases of altitiudeRange into a string and convert the _Boolean_ value of precipitationFlag to either true or false. Run the app and I bet you agree with me that we're basically done. And yet... the app is kinda of blah. 

Blah is OK. When you create your own apps focus on the basic features and get them working. Worry about making it pretty after you've got it up and running. This way you can focus on what is important, espcially if you are short on time!

Let's spice it up with headers, color, style, and pictures!

## Application Part 3

### Section Headers

We have three sections of clouds but no idea how they are grouped! Is the first section the high altitude clouds or the low altitude clouds? I wrote the code and I don't remember.

A section header for each section is a great idea. We can use the same technique of prototype cell on the storyboard and dequeueReusableCell in the code to add a header to each section.

Start with the storyboard:
1. Select the Cloud Atlas Scene's Table View and set the _Prototype Cells_ from 1 to 2. We get a nice duplicate prototype cell below the original one!
1. Select the new cell and change its _Identifier_ to "Cell2". Set it's _Style_ to _Right Detail_ and its _Accessory_ to _None_.
1. Select the title label and set it's _Font Style_ to _Bold_.
1. Select the detail label and set it's _Font_ to _System Italic_.
1. To make sure iOS doesn't add any height to these section headers  select the Cloud Atlas Table View and set the _Sections Header Height_ to 44 and the _Sections Footer Height_ to 1 (in the Size Inspector).

If you were to run the app now you won't see this new prototype cell as we have not added the code to dequeue it. You can have has many prototype cells as you need and only show then when you need to.

Go to _CloudModel.swift_ and update the _CloudAlditute_ enum so it returns the strings we're going to use to popular our section headers based on the enum case.

````
enum CloudAltitude: Int {
    
    case low = 0, mid, high, count
    
    var longName: String {
        switch self {
        case .low:
            return "Low-Level Clouds"
        case .mid:
            return "Mid-level Clouds"
        case .high:
            return "High-Level Clouds"
        default:
            return ""
        }
    }
    
    var feet: String {
        switch self {
        case .low:
            return "6,500 feet"
        case .mid:
            return "23,000 feet"
        case .high:
            return "40,000 feet"
        default:
            return ""
        }
    }
}
````

Go to _ViewController.swift_ and implement the _tableView_  methods _viewForHeaderInSection_ and _heightForHeaderInSection_ so that our app knows when to display our section headers and what data to display inside them!

````
// MARK:- Section Headers

override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2")
    cell?.textLabel!.text = CloudAltitude(rawValue: section)?.longName
    cell?.detailTextLabel!.text = CloudAltitude(rawValue: section)?.feet

    return cell

}

override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 44
}
````

Cloud Image attribution : Fir0002/Flagstaffotos







    







