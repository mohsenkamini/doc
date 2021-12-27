# nftables
## Netfilter hooks into Linux networking packet flows
![Netfilter hooks into Linux networking packet flows](https://github.com/spmzt/doc/blob/main/nf-hooks.png)
## Tables
Filter packet by address family
### Add Tables
```bash
nft add table inet example_table
```
### List Tables
```bash
nft list tables
```
### Delete Tables
```bash
nft delete table inet example_table
```
### Flush Tables
```bash
nft flush table inet example_table
```
## Chains
Filter packet directly with chain types or by a jump.
### Chain Types
The possible chain types are:
- filter, which is used to filter packets. This is supported by the arp, bridge, ip, ip6 and inet table families.
- route, which is used to reroute packets if any relevant IP header field or the packet mark is modified. If you are familiar with iptables, this chain type provides equivalent semantics to the mangle table but only for the output hook (for other hooks use type filter instead). This is supported by the ip, ip6 and inet table families.
- nat, which is used to perform Networking Address Translation (NAT). Only the first packet of a given flow hits this chain; subsequent packets bypass it. Therefore, never use this chain for filtering. The nat chain type is supported by the ip, ip6 and inet table families.
### Hook Types
The possible hooks that you can use when you configure your base chain are:
- ingress (only in netdev family since Linux kernel 4.2, and inet family since Linux kernel 5.10): sees packets immediately after they are passed up from the NIC driver, before even prerouting. So you have an alternative to **tc**.
- prerouting: sees all incoming packets, before any routing decision has been made. Packets may be addressed to the local or remote systems.
- input: sees incoming packets that are addressed to and have now been routed to the local system and processes running there.
- forward: sees incoming packets that are not addressed to the local system.
- output: sees packets that originated from processes in the local machine.
- postrouting: sees all packets after routing, just before they leave the local system.
### Priority
[Priority within hook](https://wiki.nftables.org/wiki-nftables/index.php/Netfilter_hooks#Priority_within_hook)
### Add Chains (Direct)
```bash
nft add chain inet example_table example_chain '{type filter hook input priority 0; }'
```
### Add Chains (Regular)
regular chains lack hooks, they do not receive packets automatically. Instead, they rely on rules using the jump or goto action to relay packets to them.
```bash
nft add chain inet example_table example_chain
```
### Delete Chains
```bash
nft delete chain inet example_table example_chain
```
### Flush Chains
```bash
nft flush chain inet example_table example_chain
```
## Rules
Rules receive the packets filtered by chains and take actions on them based on whether they match particular criteria. Each rule consists of two parts, which follow the table and chain in the command. First, the rule has zero or more expressions which give the criteria for the rule. Second, the rule has one or more statements which determine the action or actions taken when a packet matches the rule’s expressions. Both expressions and statements are evaluated from left to right. See the following example for adding a rule to get a breakdown of these two parts.
```bash
nft add rule inet example_table example_chain tcp dport 22 counter accept
```
- match (like tcpdump expression)
- action (accept or drop must be end of the line)
