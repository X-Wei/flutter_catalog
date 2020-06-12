![CloudBees Rollout](https://1ko9923xosh2dsbjsxpwqp45-wpengine.netdna-ssl.com/wp-content/themes/rollout/images/rollout_white_logo1.png)

[![Integration status](https://app.rollout.io/badges/5ee33fb5139193c9eb4696d6)](https://app.rollout.io/app/5ee33e979b2a55a9cbe699de/settings/info)

This repository is a YAML represnetation for Rollout configuration, it is connected (see badge for status) to Rollout service via [Rollout's github app](https://github.com/apps/rollout-io)
Configuration as code allows the entire configuration of Rollout's state to be stored as source code. It integrates Rollout's UI with engineering existing environment. This approach brings a lot of benefits.


# What is Rollout
Rollout is a multi-platform, infrastructure as code, software as a service feature management and remote configuration solution.

# What Are Feature Flags

Feature Flags is a powerfull technique based on remotetly and conditionaly opening/closing features threw the entire feature developement and delivery process.  As Martin Fowler writes on [Feature Toggles (aka Feature Flags)](https://martinfowler.com/articles/feature-toggles.html)

> Feature Toggles (often also refered to as Feature Flags) are a powerful technique, allowing teams to modify system behavior without changing code. They fall into various usage categories, and it's important to take that categorization into account when implementing and managing toggles. Toggles introduce complexity. We can keep that complexity in check by using smart toggle implementation practices and appropriate tools to manage our toggle configuration, but we should also aim to constrain the number of toggles in our system.

You can read more about the Advantages of having Rollout configuration stored and treated as code in [Rollout's support doc](https://support.rollout.io/docs/configuration-as-code)


# Repository, Directories and YAML structure
## Branches are Environments

Every environment on Rollout dashboard is mapped to a branch in git. The same name that is used for the environment will be used for the branch name. The only exception being Production environment which is mapped to `master` branch

## Directory structure

Rollout repository integration creates the following directory structure:
```
.
├── experiments             # Experiments definitions
│   └──  archived           # Archived experiments definitions
├── target_groups           # Target groups definitions
└── README.md
```

- All experiments are located under the experiment folder
- All archived experiments are located under the `experiments/archived` folder

## Experiment Examples

### False for all users
```yaml
flag: default.followingView
type: experiment
name: following view
value: false
```
This YAML representation in Rollout's dashboard:
![dashboard](https://files.readme.io/00b37e6-Screen_Shot_2018-12-03_at_11.47.56.png)
### 50% split
```yaml
flag: default.followingView
type: experiment
name: following view
value:
  - option: true
    percentage: 50
```
This YAML representation in Rollout's dashboard:
![dashboard](https://files.readme.io/5af4d9e-Screen_Shot_2018-12-03_at_12.01.28.png)
### Open feature for QA and Beta Users on version 3.0.1, otherwise close it
```yaml
flag: default.followingView
type: experiment
name: following view
conditions:
  - group:
      name:
        - QA
        - Beta Users
    version:
      operator: semver-gte
      semver: 3.0.1
    value: true
value: false
```
This YAML representation in Rollout's dashboard:
![dashboard](https://files.readme.io/6884476-Screen_Shot_2018-12-03_at_12.04.13.png)
### Open feature for all platform beside Android
```yaml
flag: default.followingView
type: experiment
name: following view
platforms:
  - name: Android
    value: false
value: true
```
Dashboard default platfrom configuration:
![dashboard](https://files.readme.io/461c854-Screen_Shot_2018-12-04_at_10.19.59.png)
Dashboard Android configuration:
![dashboard](https://files.readme.io/1aafd04-Screen_Shot_2018-12-03_at_21.39.52.png)
## Experiment YAML

This section describes the yaml scheme for an experiment. It is a composite of 3 schemas:


-  [Root schema ](doc:configuration-as-code#section-root-schema)  - the base schema for experiment
-  [Splited Value schema](doc:configuration-as-code#section-splitedvalue-schema)  - Represents a splited value -  a value that is distributed among different instances based on percentage
-  [Scheduled Value schema](doc:configuration-as-code#section-scheduledvalue-schema)  - Represents a scheduled value -  a value that is based on the time that the flag was evaluated
-  [Condition schema](doc:configuration-as-code#section-condition-schema)  - Specify how to target a specific audience/device
-  [Platform schema](doc:configuration-as-code#section-platform-schema)  - Specify how to target a specific platform



### Root Schema
An Experiment controls the flag value in runtime:

```yaml
# Yaml api version
# Optional: defaults to "1.0.0"
version: Semver

# Yaml Type (required)
type: "experiment"

# The flag being controlled by this experiment (required)
flag: String

# The available values that this flag can be
# Optional=[false, true]
availableValues: [String|Bool]

# The name of the experiment
# Optional: default flag name
name: String

# The Description of the experiment
# Optional=""
description: String

# Indicates if the experiment is active
# Optional=true
enabled: Boolean

# Expriment lables
# Optional=[]
labels: [String]|String

# Stickiness property that controls percentage based tossing
# Optional="rox.distict_id"
stickinessProperty: String

# Platfrom explicit targeting
# Optional=[]
platforms: [Platfrom]  # see Platfrom schema

# Condition and values for default platfomr
# Optional=[]
conditions: [Condition] # see Condition schema

# Value when no Condition is met
# Optional
#  false for boolean flags
#  [] for enum flags  (indicates default value)
value: String|Boolean|[SplitedValue]|[ScheduledValue]
```

### SplitedValue Schema
```yaml
# Percentage, used for splitting traffic across different values
# Optional=100
percentage: Number

# The Value to be delivered
option: String|Boolean
```
### ScheduledValue Schema
```yaml
# The Date from which this value is relevant
# Optional=undefined
from: Date

# Percentage, used for splitting traffic across different values
# Optional=100
percentage: Number
```
### Condition Schema

The Condition is a pair of condition and value, an array of conditions can be viewed as an if-else statement by the order of conditions

The schema contains three types of condition statements
- Dependency - express flag dependencies, by indicating flag name and expected value
- Groups - a list of target-groups and the operator that indicates the relationship between them (`or`|`and`|`not`)
- Version -  comparing the version of
[/block]
The relationship between these items is `and`, meaning:
       If the dependency is met `and` Groups matches `and` Version matches  `then` flage=value

Here is the Condition schema
```yaml
# Condition this flag value with another flag value
dependency:
    # Flag Name
    flag: String
    # The expected Flag Value
    value: String|Boolean

# Condition flag value based on target group(s)
group:
    # The logical relationship between the groups
    # Optional = or
    operator: or|and|not

    # Name of target groups
    name: [String]|String

# Condition flag value based release version
version:
    # The operator to compare version
    operator: semver-gt|semver-gte|semver-eq|semver-ne|semver-lt|semver-lte

    # The version to compare to
    semver: Semver

# Value when Condition is met
value: String|Boolean|[SplitedValue]|[ScheduledValue]
```
### Platform Schema
The platform object indicates a specific targeting for a specific platform

```yaml
# Name of the platform, as defined in the SDK running
name: String

# Override the flag name, when needed
# Optional = experiment flag name
flag: String

# Condition and values for default platfomr
# Optional=[]
conditions: [Condition] # see Condition schema

# Value when no Condition is met
# Optional
#  false for boolean flags
#  [] for enum flags  (indicates default value)
value: String|Boolean|[SplitedValue]|[ScheduledValue] # see Value schema
```


## Target Group Examples
### List of matching userid
```yaml
type: target-group
name: QA
conditions:
  - operator: in-array
    property: soundcloud_id
    operand:
      - 5c0588007cd291cca474454f
      - 5c0588027cd291cca4744550
      - 5c0588037cd291cca4744551
      - 5c0588047cd291cca4744552
      - 5c0588047cd291cca4744553
```

![dashboard](https://files.readme.io/7affbbe-Screen_Shot_2018-12-03_at_21.47.05.png)
### Using number property for comparison

```yaml
type: target-group
name: DJ
conditions:
  - operator: gte
    property: playlist_count
    operand: 100
description: Users with a lot of playlists
```

On rollout Dashboard
![dashboard](https://files.readme.io/dcb562f-Screen_Shot_2018-12-03_at_21.43.19.png)
## Target Group YAML

A Target group is a set of rules on top of custom properties that are defined in runtime, it is used in experiments conditions

```yaml
# Yaml api version
# Optional: defaults to "1.0.0"
version: Semver

# Yaml Type (required)
type: "target-group"

#Target Group Name
name: String

# Target Group description
# Optional = ""
description: String

# The logical relationship between conditions
# Optional = and
operator: or|and

# Array of Conditions that have a logical AND relationship between them
conditions:
    # The Custom property to be conditioned (first operand)
  - property: String

    # The Operator of the confition
    operator: is-undefined|is-true|is-false|eq|ne|gte|gt|lt|lte|regex|semver-gt|semver-eq|semver-gte|semver-gt|semver-lt|semver-lte

    # The Second operand of the condition
    # Optional - Based on operator  (is-undefined, is-true, is-false)
    operand: String|Number|[String]
```

# See Also:
- Using Roxy docker image for Microservices Automated Testing and Local development [here](https://support.rollout.io/docs/microservices-automated-testing-and-local-development)
- Configuration as Code advantages [here](https://support.rollout.io/docs/configuration-as-code#section-advantages-of-configuration-as-code)
- Integration walkthrough [here](https://support.rollout.io/docs/configuration-as-code#section-connecting-to-github-cloud)


Please contact support@rollout.io for any issues questions or suggestions you might have
