Return-Path: <linux-sctp+bounces-52-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C5A890351
	for <lists+linux-sctp@lfdr.de>; Thu, 28 Mar 2024 16:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE4E0295A20
	for <lists+linux-sctp@lfdr.de>; Thu, 28 Mar 2024 15:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FA112FF81;
	Thu, 28 Mar 2024 15:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fakwicaw"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52B712FB00;
	Thu, 28 Mar 2024 15:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711640440; cv=none; b=N3CnH852tgwWof+MdB6RvlLfurTaS+OC/qspoOMejhW11g3AnrCWAR51PHiC8bow6Xwe5pkXMMCXM3uX7Sg8OzGXwOxCA3dvYKBU6KJXXyYd/TvTR/0RL3bDNjS10+B5fwZ+ixzmgNhFH79hDYZ3j0MoWbEITRl0tRZLmh6HYro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711640440; c=relaxed/simple;
	bh=ud3T69MK4aFdCRC9hOuXv5ucdpcOyL/1OVLr0wfxXKs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=k7fKJutS2YkGF2Z/oohyBG6HcjAWuBRM6d+Lw/VRlYtsKu8N5YlyZGa/UMsfYxqdbN20G7YoUlBc9Qd2puJ4PQhiDcc4sfgEVE7KqGXXux2rX95UvsBFMcqC6YOnNB+hk/DLDCk3T9VrLjMij24P9/JfEqmrOYA/1x3fGYKb49k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fakwicaw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 75000C433F1;
	Thu, 28 Mar 2024 15:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711640439;
	bh=ud3T69MK4aFdCRC9hOuXv5ucdpcOyL/1OVLr0wfxXKs=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Fakwicaw25gquYnRS1SEMWjgKR7/s0ZvEoBt/HNBBud0cpItyJOoqCgQchBDqUKK5
	 bemfeY3QmHJxlV1GIufUGP8VybfyXgY2LTWynGDDz1y6+dXOZLWU6MlXkdcW3LMmnR
	 J6fTa0JOiyv2r0XWJDCKJgzZq0sIoiO2mskQxhRqp8z+TVJ5AthAji0ryicJbNJzyQ
	 C0d3tlKneV99gEItvgKSmBuJVOt8jFN0ed/fsRykUCLWiXFzi5kFWzPooEQtEOCphG
	 8zN+C2V6SrF2Wr4R6i/JYSGXYTU9/fy+2g9a0SQiqqjaLoBHkK2i8h1Ga8Xeym+SV2
	 Atkyr9lQVeJog==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452C7CD1283;
	Thu, 28 Mar 2024 15:40:39 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Subject: [PATCH v2 0/4] sysctl: Remove sentinel elements from networking
Date: Thu, 28 Mar 2024 16:40:01 +0100
Message-Id: <20240328-jag-sysctl_remset_net-v2-0-52c9fad9a1af@samsung.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFGPBWYC/3WNwQqDMBBEf0X23BQTg5Ce+h9FZDXbmFKjZFOpi
 P/eVOixxzfDvNmAKXpiuBQbRFo8+ylkUKcC+gGDI+FtZlCl0mUlpXigE7xyn55tpJEptYGSsLl
 EiaaydQd5O0e6+/fhvTWZB89piutxs8hv+jPqP8ZFilIgqrrT2ipjzZVx5Fdw534aodn3/QORQ
 jIKvAAAAA==
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Alexander Aring <alex.aring@gmail.com>, 
 Stefan Schmidt <stefan@datenfreihafen.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, David Ahern <dsahern@kernel.org>, 
 Steffen Klassert <steffen.klassert@secunet.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, Ralf Baechle <ralf@linux-mips.org>, 
 Remi Denis-Courmont <courmisch@gmail.com>, 
 Allison Henderson <allison.henderson@oracle.com>, 
 David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
 Xin Long <lucien.xin@gmail.com>, Wenjia Zhang <wenjia@linux.ibm.com>, 
 Jan Karcher <jaka@linux.ibm.com>, "D. Wythe" <alibuda@linux.alibaba.com>, 
 Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>, 
 Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Anna Schumaker <anna@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Jon Maloy <jmaloy@redhat.com>, 
 Ying Xue <ying.xue@windriver.com>, Martin Schiller <ms@dev.tdt.de>, 
 Pablo Neira Ayuso <pablo@netfilter.org>, 
 Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>, 
 Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, 
 Simon Horman <horms@verge.net.au>, Julian Anastasov <ja@ssi.bg>, 
 Joerg Reuter <jreuter@yaina.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Kees Cook <keescook@chromium.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dccp@vger.kernel.org, linux-wpan@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-hams@vger.kernel.org, linux-rdma@vger.kernel.org, 
 rds-devel@oss.oracle.com, linux-afs@lists.infradead.org, 
 linux-sctp@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-nfs@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
 linux-x25@vger.kernel.org, netfilter-devel@vger.kernel.org, 
 coreteam@netfilter.org, bridge@lists.linux.dev, lvs-devel@vger.kernel.org, 
 Joel Granados <j.granados@samsung.com>
X-Mailer: b4 0.13-dev-2d940
X-Developer-Signature: v=1; a=openpgp-sha256; l=13824;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=8VCyRKjyYVGSOadr+6Ic449iaGb2H4p0ANna6tf5xaU=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGYFj3Ln2OuFAVa0yWccBAGiHs7zijnTe9xzp
 /gzvL8IzSQ2tIkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJmBY9yAAoJELqXzVK3
 lkFPeNQL/iRU0WVs1AN/1595l0/G2WL7+0AEZMSIWPwi16BYLDIkgaMlUVb2Up2YYQ3CpLosSu2
 ENwaloenrJUmo96weKnydcyJk97Hm74kWNQ4YPibkv95wYgoZ78KeRyU8od94sAJZO6jHbY9IZJ
 BubC4RRLZGtunJRrvOtkbzel/jOhjpUnKawdmvHhYWG18Hjqt3lm4x4+fUeN2W1hZxoUOgJK+pH
 Bdiqc0Z7eFD00R23NSsPvo/DHRW8rzI3ZHuiBQLsteiNGMLgTO+NdYZqP3jM8xISir2TzibsTbe
 Rabu23PiJ6yyFNdwdJ1oi4ubi9cG28Wyql/LD7LU/CInjA0ZC/vviaY7aH4x6hOhf7YBpSJLWgf
 oC4qurWeEn3vVWhTWX7IAibFCFMhlGvFcTOFLbJMET5wHZE59vFvy8WZSNDEjLTw81GKJFBOqWa
 7gdhYA8fy5dvcJWcnyUbkzWd5tROGxMxzsXEi+7CpAwOX0AWzwQL0fbrZVDV7jIgWs+dQVqZIK6
 LI=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for j.granados@samsung.com/default with
 auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
Reply-To: j.granados@samsung.com

From: Joel Granados <j.granados@samsung.com>

What?
These commits remove the sentinel element (last empty element) from the
sysctl arrays of all the files under the "net/" directory that register
a sysctl array. The merging of the preparation patches [4] to mainline
allows us to just remove sentinel elements without changing behavior.
This is safe because the sysctl registration code (register_sysctl() and
friends) use the array size in addition to checking for a sentinel [1].

Why?
By removing the sysctl sentinel elements we avoid kernel bloat as
ctl_table arrays get moved out of kernel/sysctl.c into their own
respective subsystems. This move was started long ago to avoid merge
conflicts; the sentinel removal bit came after Mathew Wilcox suggested
it to avoid bloating the kernel by one element as arrays moved out. This
patchset will reduce the overall build time size of the kernel and run
time memory bloat by about ~64 bytes per declared ctl_table array (more
info here [5]).

When are we done?
There are 4 patchest (25 commits [2]) that are still outstanding to
completely remove the sentinels: files under "net/" (this patchset),
files under "kernel/" dir, misc dirs (files under mm/ security/ and
others) and the final set that removes the unneeded check for ->procname
== NULL.

Testing:
* Ran sysctl selftests (./tools/testing/selftests/sysctl/sysctl.sh)
* Ran this through 0-day with no errors or warnings

Savings in vmlinux:
  A total of 64 bytes per sentinel is saved after removal; I measured in
  x86_64 to give an idea of the aggregated savings. The actual savings
  will depend on individual kernel configuration.
    * bloat-o-meter
        - The "yesall" config saves 3976 bytes (bloat-o-meter output [6])
        - A reduced config [3] saves 1263 bytes (bloat-o-meter output [7])

Savings in allocated memory:
  None in this set but will occur when the superfluous allocations are
  removed from proc_sysctl.c. I include it here for context. The
  estimated savings during boot for config [3] are 6272 bytes. See [8]
  for how to measure it.

Comments/feedback greatly appreciated

Changes in v2:
- Rebased to v6.9-rc1
- Removed unneeded comment from sysctl_net_ax25.c
- Link to v1: https://lore.kernel.org/r/20240314-jag-sysctl_remset_net-v1-0-aa26b44d29d9@samsung.com

Best
Joel

[1] https://lore.kernel.org/all/20230809105006.1198165-1-j.granados@samsung.com/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/joel.granados/linux.git/tag/?h=sysctl_remove_empty_elem_v5
[3] https://gist.github.com/Joelgranados/feaca7af5537156ca9b73aeaec093171
[4] https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/

[5]
Links Related to the ctl_table sentinel removal:
* Good summaries from Luis:
  https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/
  https://lore.kernel.org/all/ZMFizKFkVxUFtSqa@bombadil.infradead.org/
* Patches adjusting sysctl register calls:
  https://lore.kernel.org/all/20230302204612.782387-1-mcgrof@kernel.org/
  https://lore.kernel.org/all/20230302202826.776286-1-mcgrof@kernel.org/
* Discussions about expectations and approach
  https://lore.kernel.org/all/20230321130908.6972-1-frank.li@vivo.com
  https://lore.kernel.org/all/20220220060626.15885-1-tangmeng@uniontech.com

[6]
add/remove: 0/1 grow/shrink: 2/67 up/down: 76/-4052 (-3976)
Function                                     old     new   delta
llc_sysctl_init                              306     377     +71
nf_log_net_init                              866     871      +5
sysctl_core_net_init                         375     366      -9
lowpan_frags_init_net                        618     598     -20
ip_vs_control_net_init_sysctl               2446    2422     -24
sysctl_route_net_init                        521     493     -28
__addrconf_sysctl_register                   678     650     -28
xfrm_sysctl_init                             405     374     -31
mpls_net_init                                367     334     -33
sctp_sysctl_net_register                     386     346     -40
__ip_vs_lblcr_init                           546     501     -45
__ip_vs_lblc_init                            546     501     -45
neigh_sysctl_register                       1011     958     -53
mpls_dev_sysctl_register                     475     419     -56
ipv6_route_sysctl_init                       450     394     -56
xs_tunables_table                            448     384     -64
xr_tunables_table                            448     384     -64
xfrm_table                                   320     256     -64
xfrm6_policy_table                           128      64     -64
xfrm4_policy_table                           128      64     -64
x25_table                                    448     384     -64
vs_vars                                     1984    1920     -64
unix_table                                   128      64     -64
tipc_table                                   448     384     -64
svcrdma_parm_table                           832     768     -64
smc_table                                    512     448     -64
sctp_table                                   256     192     -64
sctp_net_table                              2304    2240     -64
rxrpc_sysctl_table                           704     640     -64
rose_table                                   704     640     -64
rds_tcp_sysctl_table                         192     128     -64
rds_sysctl_rds_table                         384     320     -64
rds_ib_sysctl_table                          384     320     -64
phonet_table                                 128      64     -64
nr_table                                     832     768     -64
nf_log_sysctl_table                          768     704     -64
nf_log_sysctl_ftable                         128      64     -64
nf_ct_sysctl_table                          3200    3136     -64
nf_ct_netfilter_table                        128      64     -64
nf_ct_frag6_sysctl_table                     256     192     -64
netns_core_table                             320     256     -64
net_core_table                              2176    2112     -64
neigh_sysctl_template                       1416    1352     -64
mptcp_sysctl_table                           576     512     -64
mpls_dev_table                               128      64     -64
lowpan_frags_ns_ctl_table                    256     192     -64
lowpan_frags_ctl_table                       128      64     -64
llc_station_table                             64       -     -64
llc2_timeout_table                           320     256     -64
ipv6_table_template                         1344    1280     -64
ipv6_route_table_template                    768     704     -64
ipv6_rotable                                 320     256     -64
ipv6_icmp_table_template                     448     384     -64
ipv4_table                                  1024     960     -64
ipv4_route_table                             832     768     -64
ipv4_route_netns_table                       320     256     -64
ipv4_net_table                              7552    7488     -64
ip6_frags_ns_ctl_table                       256     192     -64
ip6_frags_ctl_table                          128      64     -64
ip4_frags_ns_ctl_table                       320     256     -64
ip4_frags_ctl_table                          128      64     -64
devinet_sysctl                              2184    2120     -64
debug_table                                  384     320     -64
dccp_default_table                           576     512     -64
ctl_forward_entry                            128      64     -64
brnf_table                                   448     384     -64
ax25_param_table                             960     896     -64
atalk_table                                  320     256     -64
addrconf_sysctl                             3904    3840     -64
vs_vars_table                                256     128    -128
Total: Before=440631035, After=440627059, chg -0.00%

[7]
add/remove: 0/0 grow/shrink: 1/22 up/down: 8/-1263 (-1255)
Function                                     old     new   delta
sysctl_route_net_init                        189     197      +8
__addrconf_sysctl_register                   306     294     -12
ipv6_route_sysctl_init                       201     185     -16
neigh_sysctl_register                        385     366     -19
unix_table                                   128      64     -64
netns_core_table                             256     192     -64
net_core_table                              1664    1600     -64
neigh_sysctl_template                       1416    1352     -64
ipv6_table_template                         1344    1280     -64
ipv6_route_table_template                    768     704     -64
ipv6_rotable                                 192     128     -64
ipv6_icmp_table_template                     448     384     -64
ipv4_table                                   768     704     -64
ipv4_route_table                             832     768     -64
ipv4_route_netns_table                       320     256     -64
ipv4_net_table                              7040    6976     -64
ip6_frags_ns_ctl_table                       256     192     -64
ip6_frags_ctl_table                          128      64     -64
ip4_frags_ns_ctl_table                       320     256     -64
ip4_frags_ctl_table                          128      64     -64
devinet_sysctl                              2184    2120     -64
ctl_forward_entry                            128      64     -64
addrconf_sysctl                             3392    3328     -64
Total: Before=8523801, After=8522546, chg -0.01%

[8]
To measure the in memory savings apply this on top of this patchset.

"
diff --git i/fs/proc/proc_sysctl.c w/fs/proc/proc_sysctl.c
index 37cde0efee57..896c498600e8 100644
--- i/fs/proc/proc_sysctl.c
+++ w/fs/proc/proc_sysctl.c
@@ -966,6 +966,7 @@ static struct ctl_dir *new_dir(struct ctl_table_set *set,
        table[0].procname = new_name;
        table[0].mode = S_IFDIR|S_IRUGO|S_IXUGO;
        init_header(&new->header, set->dir.header.root, set, node, table, 1);
+       printk("%ld sysctl saved mem kzalloc\n", sizeof(struct ctl_table));

        return new;
 }
@@ -1189,6 +1190,7 @@ static struct ctl_table_header *new_links(struct ctl_dir *dir, s>
                link_name += len;
                link++;
        }
+       printk("%ld sysctl saved mem kzalloc\n", sizeof(struct ctl_table));
        init_header(links, dir->header.root, dir->header.set, node, link_table,
                    head->ctl_table_size);
        links->nreg = nr_entries;
"
and then run the following bash script in the kernel:

accum=0
for n in $(dmesg | grep kzalloc | awk '{print $3}') ; do
    accum=$(calc "$accum + $n")
done
echo $accum

Signed-off-by: Joel Granados <j.granados@samsung.com>

--

---
---
Joel Granados (4):
      networking: Remove the now superfluous sentinel elements from ctl_table array
      netfilter: Remove the now superfluous sentinel elements from ctl_table array
      appletalk: Remove the now superfluous sentinel elements from ctl_table array
      ax.25: Remove the now superfluous sentinel elements from ctl_table array

 net/appletalk/sysctl_net_atalk.c        | 1 -
 net/ax25/sysctl_net_ax25.c              | 4 +---
 net/bridge/br_netfilter_hooks.c         | 1 -
 net/core/neighbour.c                    | 5 +----
 net/core/sysctl_net_core.c              | 9 ++++-----
 net/dccp/sysctl.c                       | 2 --
 net/ieee802154/6lowpan/reassembly.c     | 6 +-----
 net/ipv4/devinet.c                      | 5 ++---
 net/ipv4/ip_fragment.c                  | 2 --
 net/ipv4/route.c                        | 8 ++------
 net/ipv4/sysctl_net_ipv4.c              | 7 +++----
 net/ipv4/xfrm4_policy.c                 | 1 -
 net/ipv6/addrconf.c                     | 5 +----
 net/ipv6/icmp.c                         | 1 -
 net/ipv6/netfilter/nf_conntrack_reasm.c | 1 -
 net/ipv6/reassembly.c                   | 2 --
 net/ipv6/route.c                        | 5 -----
 net/ipv6/sysctl_net_ipv6.c              | 4 +---
 net/ipv6/xfrm6_policy.c                 | 1 -
 net/llc/sysctl_net_llc.c                | 8 ++------
 net/mpls/af_mpls.c                      | 3 +--
 net/mptcp/ctrl.c                        | 1 -
 net/netfilter/ipvs/ip_vs_ctl.c          | 5 +----
 net/netfilter/ipvs/ip_vs_lblc.c         | 5 +----
 net/netfilter/ipvs/ip_vs_lblcr.c        | 5 +----
 net/netfilter/nf_conntrack_standalone.c | 6 +-----
 net/netfilter/nf_log.c                  | 3 +--
 net/netrom/sysctl_net_netrom.c          | 1 -
 net/phonet/sysctl.c                     | 1 -
 net/rds/ib_sysctl.c                     | 1 -
 net/rds/sysctl.c                        | 1 -
 net/rds/tcp.c                           | 1 -
 net/rose/sysctl_net_rose.c              | 1 -
 net/rxrpc/sysctl.c                      | 1 -
 net/sctp/sysctl.c                       | 6 +-----
 net/smc/smc_sysctl.c                    | 1 -
 net/sunrpc/sysctl.c                     | 1 -
 net/sunrpc/xprtrdma/svc_rdma.c          | 1 -
 net/sunrpc/xprtrdma/transport.c         | 1 -
 net/sunrpc/xprtsock.c                   | 1 -
 net/tipc/sysctl.c                       | 1 -
 net/unix/sysctl_net_unix.c              | 1 -
 net/x25/sysctl_net_x25.c                | 1 -
 net/xfrm/xfrm_sysctl.c                  | 5 +----
 44 files changed, 26 insertions(+), 106 deletions(-)
---
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20240311-jag-sysctl_remset_net-d403a1a93d6b

Best regards,
-- 
Joel Granados <j.granados@samsung.com>



