
<p align="center">

  <h2 align="center">ScyllaDB- Changing Replication Factor</h2>

  <p align="center">
    Change Replication Factor for multiple ScyllaDB keyspaces at once!
    <br />
    <a href="https://github.com/Aradhana-Singh/ScyllaDB-ReplicationFactor#readme"><strong>Explore the docs »</strong></a>
    <br />
  </p>
</p>




<!-- ABOUT THE PROJECT -->
## About The Project

Scylla replicates data according to a replication strategy that you choose. This strategy will determine the placement of the replicated data. The Replication Factor (RF) is equivalent to the number of nodes where data (rows and partitions) is replicated. Data is replicated to multiple (RF=N) nodes.
<br>
One can change the RF for all the keyspaces present in the scylla database but as the replication factor and replication strategy is associated with each keyspace separately, you need to change the RF for each keyspace one by one. 
<br>
The script present in this project lets you change the replication factor of multiple keyspaces at once.

<!-- GETTING STARTED -->
## Getting Started

This is an example of how you can use this script to change the Replication factor of your scylla cluster.

### Prerequisites

  * Atleast one scylla node running.

### Usage

1. Clone this repo in the system where scylla node is running
  
    ```sh
     git clone https://github.com/Aradhana-Singh/ScyllaDB-ReplicationFactor
     ```
2. Run the script file: scyllaScript.sh
  
    ```sh
     ./scyllaScript.sh
     ```
3. Following screen will appear. Choose the required options: 
      <div align="center"> <img src="https://user-images.githubusercontent.com/62242144/127299026-53648d64-b515-470e-ae5d-608b970d5a65.PNG"> </div>
      
      * Choose Option 1.  To change replication factor for all the keyspaces except the system keyspaces.
      * Choose Option 2. To change only the keyspaces created by alternator (all the keyspaces with names starting with "alternator_")
      * Choose Option 3. To manually provide list of keyspaces (provide space separated list of names) 
     
 4. Provide the value for Replication factor, Replication Strategy and the name of Datacenter to change. 
       <div align="center"> <img src="https://user-images.githubusercontent.com/62242144/127300346-f63548ec-8ca9-42b6-b36d-d98e64bb674e.PNG"> </div>
      <p>This might take a few minutes. Once the process completes you can check the new RF values for each keyspaces by using following cql command: </p>
   
      ```sql
        SELECT * FROM system_schema.keyspaces
      ```
  5. It is recommended to do a node repair after changing the RF in scyllaDB. To do a full node repair use the following command: 
      ```
        Nodetool repair -full
      ```
      
      
<!-- CONTACT -->
## Contact

email: aradhana971127@gmail.com

Project Link: [https://github.com/Aradhana-Singh/ScyllaDB-ReplicationFactor](https://github.com/Aradhana-Singh/ScyllaDB-ReplicationFactor)



