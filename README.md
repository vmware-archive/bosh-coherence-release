# bosh-coherence-release
Bosh release for Oracle Coherence cache servers (Experimental) on bosh-lite

## Steps

* Add the Oracle jre (1.7 or later) binary install and coherence jars as blobs using the addDependencies.sh script
 * Jre and coherence binaries should be available or downloaded ahead of time before running addDependencies script (they are not part of this project).
* Create the release
* Upload the release
* Use the sample boshlite deployment manifest to come up with a custom manifest and deploy to bosh-lite
  * Its possible to deploy the relase on vsphere also, would require creating a custom deployment manifest for vsphere.
* Tweak the number of master and slave instances as required.

## Clustering

* Unicast Cluster
This bosh release for coherence relies on unicast as multicast is quite often blocked between vms. In order to join the membership, atleast some of the members should be running on a well known address (wka) for other members to join them and connect to the cluster and advertising about other new members not in the wka list. The members running on wka addresses would be termed as Master (atleast one master should be running all times) and the slaves are dynamic members who only know about the masters at startup time. The number of master instances is recommended to be atleast 2 to provide HA and the slaves can be any number of instances. Tweak the master ip list in the deployment manifest to identify specific ips to use for master and the rest of allocatable floating ips can be used for slaves.

* Caches
Edit the provided cache templates (under src) to create named cached or configure it differently.

* Clients
The Coherence clients would have to know minimum of one master wka address to communicate with the cluster.

## Notice
This is a purely experimental release to be used for development purpose and is not officially supported in any form or fashion.
