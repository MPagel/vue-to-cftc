# Project goal of vue-to-cftc #
This repository enables the field biologist maintaining a CFTC core array receiver to submit data in a format acceptable to our database.<br>
This is achieved by providing the scientist with a series of useful, small programs, a corresponding Microsoft Access Database and instruction for use.

### System requirements
<ul><li>Windows PC<br>
</li><li>VEMCO VUE<br>
</li><li>Perl<br>
</li><li>Microsoft Access (or potentially LibreOffice Base, but I have not recently tested LO Base)
</li></ul>
 <strong>Please read the <a href='ImportToAccess.txt'>ImportToAccess.txt</a> file for more details</strong><br>

### File requirements
  <ul><li>Acoustic telemetry __VRL__ (or __.000__) files.</li>
  <li>Corresponding deployments entries in a __CSV__ or __XLS__/__XLSX__.</li>
  <li>The __.bat__ and __.pl__ scripts from this lovely online repository that you are currently viewing. You can obtain these compressed in __.zip__ format by [clicking here:floppy_disk:](../../archive/master.zip).</li></ul>

### Basic workflow
This documentation assumes that you've already used VEMCO's VUE to download your data from a receiver.

1. Create a **vdb** with time drift-corrected data.
1. <em>Optional:</em> You may choose to delete tester or beacon tags so only data on fish tags are included.
1. Export all <em>(remaining)</em> detections in **.csv** format.
1. Convert **csv** files using **.bat** and perl (**pl**)script files into CFTC format (PST time).
1. Import detections into MS Access.
1. Import or manually enter deployment records into Access.
1. Check for orphaned detections (detections outside the given deployment windows) using provided Visual Basic for Applications (VBA) macros.
1. E-mail us the resulting MS Access **.mdb** file.

### Basic script file usage instructions
 In windows drag desired **.csv** files generated by VUE output on top of one of the three <em>vue-to-cftc<strong>.bat</strong></em>s.<br>
  * vue-to-cftc-plusMS.bat - will include milliseconds in output for all detections, including those with no specified milliseconds value (0ms).
  * vue-to-cftc-noMS.bat - will never include milliseconds, even if present in VUE output. This version is the most compatible with earlier versions of Microsoft Access.
  * vue-to-cftc.bat - will include milliseconds on entries that have milliseconds available from the VUE export. On entries without specified milliseconds (or with exactly 0ms) the output will not include milliseconds. This version is untested with regard to Microsoft Access, but should be roughly as compatible as the plusMS version.
 
**Again, please read the <a href='ImportToAccess.txt'>ImportToAccess.txt</a> file for more details.**

### Bug reports[:thumbsdown:](../../issues/new)
Please first check if your bug has already been reported [here](../../issues?q=is%3Aissue).<br>
Then either create an "issue" [here](../../issues/new) or simply e-mail me.

If you have any technical problems with Git or GitHub, rather than this project specifically, [ask GitHub Support](https://github.com/contact) directly.

### Improvements and modifications[:exclamation:](../../fork)
<p>If you have improvements and modifications that you've programmed yourself, feel free to submit them to me.</p>
* On Github
  Make modifications by creating your own GitHub account and then ["forking":fork_and_knife:this project by clicking here](../../fork). You can let me know about updates and fixes you've created by doing what github calls a [pull:muscle:request, here](../../compare).  You can, in turn, check if anyone has requested to [update your fork:fork_and_knife:](../../pulls?q=is%3Apr) with THEIR modifications [here](../../pulls?q=is%3Apr).
* Offline/via e-mail
  You can choose to ["go old school" and just download:floppy_disk:](../../archive/master.zip), modify and then send me the modifications via e-mail[:mailbox:](../../issues/new). If you're having trouble tracking down my e-mail address you can [tell me your e-mail address here](../../issues/new). The github system will send me an e-mail, then I'll reply to the address you provide, so you know where to send the files.

### Other feedback[:question:](../../issues/new)
Go ahead and fill out the [same form as a bug report](../../issues/new), telling me exactly how awesome these scripts and forms are.

### Author[:book:](../../../)
  Matt Pagel<br>
  UCDavis Biotelemetry Lab<br>
  (last name at cs dot wisc.edu)<br>
  530 752-1156

My other github projects are [listed here](../../../).<br>
