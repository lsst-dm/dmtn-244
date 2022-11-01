.. image:: https://img.shields.io/badge/dmtn--244-lsst.io-brightgreen.svg
   :target: https://dmtn-244.lsst.io
.. image:: https://github.com/lsst-dm/dmtn-244/workflows/CI/badge.svg
   :target: https://github.com/lsst-dm/dmtn-244/actions/

##################################################################
Adding Workflow Management Flexibility to LSST Pipelines Execution
##################################################################

DMTN-244
========

Data processing pipelines need to be executed at scales ranging from
small runs up through large production data release runs resulting in
millions of data products.  As part of the Rubin Observatory's pipeline
execution system, bps is the abstraction layer that provides an interface
to different Workflow Management Systems (WMS) such as HTCondor and PanDA.
During the submission process, the pipeline execution system interacts
with the Data Butler to produce science-oriented execution graphs from
algorithmic tasks.  bps converts this execution graph to a workflow graph
and then uses a WMS-specific plugin to submit and manage the workflow.
Here we will discuss the architectural design of this interface and
report briefly on the recent production of the Data Preview 0.2 release
and how the system is used by pipeline developers.

Links
=====

- Live drafts: https://dmtn-244.lsst.io
- GitHub: https://github.com/lsst-dm/dmtn-244

Build
=====

This repository includes lsst-texmf_ as a Git submodule.
Clone this repository::

    git clone --recurse-submodules https://github.com/lsst-dm/dmtn-244

Compile the PDF::

    make

Clean built files::

    make clean

Updating acronyms
-----------------

A table of the technote's acronyms and their definitions are maintained in the `acronyms.tex` file, which is committed as part of this repository.
To update the acronyms table in ``acronyms.tex``::

    make acronyms.tex

*Note: this command requires that this repository was cloned as a submodule.*

The acronyms discovery code scans the LaTeX source for probable acronyms.
You can ensure that certain strings aren't treated as acronyms by adding them to the `skipacronyms.txt <./skipacronyms.txt>`_ file.

The lsst-texmf_ repository centrally maintains definitions for LSST acronyms.
You can also add new acronym definitions, or override the definitions of acronyms, by editing the `myacronyms.txt <./myacronyms.txt>`_ file.

Updating lsst-texmf
-------------------

`lsst-texmf`_ includes BibTeX files, the ``lsstdoc`` class file, and acronym definitions, among other essential tooling for LSST's LaTeX documentation projects.
To update to a newer version of `lsst-texmf`_, you can update the submodule in this repository::

   git submodule update --init --recursive

Commit, then push, the updated submodule.

.. _lsst-texmf: https://github.com/lsst/lsst-texmf
