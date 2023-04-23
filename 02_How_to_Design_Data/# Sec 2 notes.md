## Data Definitions in Program Design

Data definitions play a critical role in program design by establishing the relationship between information and data in a program. Specifically:

- Information in the program's domain is represented by data in the program.
- Data in the program can be interpreted as information in the program's domain.

A good data definition should describe how to form (or make) data that satisfies the definition, how to determine whether a data value satisfies the definition, and how to represent information in the program's domain as data and interpret a data value as information.

For instance, a data definition might specify that numbers are used to represent the speed of a ball or the height of an airplane. Without such a definition, a number like 6 could mean anything.

A data definition typically consists of:

1. A possible structure definition
2. A type comment that defines a new type name and describes how to form data of that type.
3. An interpretation that describes the correspondence between information and data.
4. One or more examples of the data.
5. A template for a 1 argument function operating on data of this type.

It's essential to choose the right kind of data definition based on the structure of the information to be represented. This choice determines the structure of the templates and helps determine the function examples (check-expects), and therefore the structure of much of the final program design.

Here is a summary table of which kind of data definition to use for different information structures:

| Form of information to be represented | Data definition to use |
| --- | --- |
| Atomic | Simple Atomic Data |
| Numbers within a certain range | Interval |
| Consists of a fixed number of distinct items | Enumeration |
| Comprised of 2 or more subclasses, at least one of which is not a distinct item | Itemization |
| Consists of two or more items that naturally belong together | Compound data |
| Naturally composed of different parts | References to other defined type |
| Of arbitrary (unknown) size | Self-referential or mutually referential |