![Adams](../img/adams_logo.png)

# Adams

The Advanced Data mining And Machine learning System ([ADAMS](https://adams.cms.waikato.ac.nz/)) is a flexible workflow engine aimed at quickly building and maintaining data-driven, reactive workflows, easily integrated into business processes, released under GPLv3.

The core of ADAMS is the workflow engine, which follows the philosophy of less is more. Instead of letting the user place operators (or actors in ADAMS terms) on a canvas and then manually connect inputs and outputs, ADAMS uses a tree-like structure. This structure and the control actors define how the data is flowing in the workflow, no explicit connections necessary. The tree-like structure stems from the internal object representation and the nesting of sub-actors within actor-handlers.
