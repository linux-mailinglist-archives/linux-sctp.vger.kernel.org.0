Return-Path: <linux-sctp+bounces-1325-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Y22iDanwUmpgVgMAu9opvQ
	(envelope-from <linux-sctp+bounces-1325-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Sun, 12 Jul 2026 03:40:57 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6855743683
	for <lists+linux-sctp@lfdr.de>; Sun, 12 Jul 2026 03:40:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=suse.de (policy=none);
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1325-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1325-lists+linux-sctp=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 74ACB3004681
	for <lists+linux-sctp@lfdr.de>; Sun, 12 Jul 2026 01:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C02C23393B;
	Sun, 12 Jul 2026 01:40:32 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D8D20D4FC
	for <linux-sctp@vger.kernel.org>; Sun, 12 Jul 2026 01:40:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783820432; cv=none; b=trPpy2MP9MQA6Kc1FJNOepm6OIuk5r4OkMLY0qqU+wvXIBS9v4wsKN798XDfWTz5X/PS1npUfoknMlAA6rlv041KJUPNwrbMHd8w4gNafkAuH/6RPGpu4RswMJteCN+isQ/GU8Tfzdvh7JO4FjTN0fXKFcPBuHGNlfWyB1C+lGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783820432; c=relaxed/simple;
	bh=DIOKVisPvX95Jb8WgVVl0GDInMQY+K5+qb8I8Kb3XwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qv6G0YzY2IDu8lOQCK31lSnB806xi6QsUOjuW7TPHKfPgUeeMflUwJfZtVY3mURJkZ6s9vjJIaZzL27iUvUgZ3NQ7tlwZDh4JveMI+ZLC7DlI0RygfX4jfo7d5lMaIXSQXZgfbMqXrdY5pgkOLNQJpA8PVsDKblqQ+Afs5a/Vx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4901976DB6;
	Sun, 12 Jul 2026 01:40:18 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F1871779B5;
	Sun, 12 Jul 2026 01:40:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0PnVN3rwUmqRegAAD6G6ig
	(envelope-from <fmancera@suse.de>); Sun, 12 Jul 2026 01:40:10 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	horms@kernel.org,
	idosch@nvidia.com,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Elad Nachman <enachman@marvell.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Saurav Kashyap <skashyap@marvell.com>,
	Javed Hasan <jhasan@marvell.com>,
	GR-QLogic-Storage-Upstream@marvell.com,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Nilesh Javali <njavali@marvell.com>,
	Manish Rangankar <mrangankar@marvell.com>,
	Varun Prakash <varun@chelsio.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Marek Lindner <marek.lindner@mailbox.org>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Sven Eckelmann <sven@narfation.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	Johannes Berg <johannes@sipsolutions.net>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Julian Anastasov <ja@ssi.bg>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Allison Henderson <achender@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Jon Maloy <jmaloy@redhat.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Vikas Gupta <vikas.gupta@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>,
	Justin Chen <justin.chen@broadcom.com>,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Yao Zi <me@ziyao.cc>,
	Yanteng Si <siyanteng@cqsoftware.com.cn>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Julian Braha <julianbraha@gmail.com>,
	Joey Lu <a0987203069@gmail.com>,
	Shangjuan Wei <weishangjuan@eswincomputing.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Inochi Amaoto <inochiama@gmail.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Qingfang Deng <qingfang.deng@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Eric Biggers <ebiggers@kernel.org>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alyssa Ross <hi@alyssa.is>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	oss-drivers@corigine.com,
	linux-net-drivers@amd.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-afs@lists.infradead.org,
	linux-nfs@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	bridge@lists.linux.dev,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	mptcp@lists.linux.dev,
	lvs-devel@vger.kernel.org,
	dev@openvswitch.org,
	rds-devel@oss.oracle.com,
	linux-sctp@vger.kernel.org,
	linux-s390@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net
Subject: [PATCH 01/13 RFC net-next] net: ipv4: introduce CONFIG_IPV4 to decouple the IPv4 stack
Date: Sun, 12 Jul 2026 03:38:59 +0200
Message-ID: <20260712013941.4570-2-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260712013941.4570-1-fmancera@suse.de>
References: <20260712013941.4570-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[suse.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-1325-lists,linux-sctp=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:dsahern@kernel.org,m:horms@kernel.org,m:idosch@nvidia.com,m:fmancera@suse.de,m:jgg@ziepe.ca,m:leon@kernel.org,m:andrew+netdev@lunn.ch,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:enachman@marvell.com,m:saeedm@nvidia.com,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:petrm@nvidia.com,m:ecree.xilinx@gmail.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:arend.vanspriel@broadcom.com,m:miriam.rachel.korenblit@intel.com,m:kbusch@kernel.org,m:axboe@kernel.dk,m:hch@lst.de,m:sagi@grimberg.me,m:kch@nvidia.com,m:skashyap@marvell.com,m:jhasan@marvell.com,m:GR-QLogic-Storage-Upstream@marvell.com,m:James.Bottomley@HansenPartnership.com,m:martin.petersen@oracle.com,m:njavali@marvell.com,m:mrangankar@marvell.com,m:varun@chelsio.com,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:dhowells@redhat.com,m:marc.dionne@auristor.co
 m,m:trondmy@kernel.org,m:anna@kernel.org,m:cel@kernel.org,m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:marek.lindner@mailbox.org,m:sw@simonwunderlich.de,m:antonio@mandelbit.com,m:sven@narfation.org,m:razor@blackwall.org,m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:johannes@sipsolutions.net,m:matttbe@kernel.org,m:martineau@kernel.org,m:geliang@kernel.org,m:ja@ssi.bg,m:aconole@redhat.com,m:echaudro@redhat.com,m:i.maximets@ovn.org,m:achender@kernel.org,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:marcelo.leitner@gmail.com,m:lucien.xin@gmail.com,m:alibuda@linux.alibaba.com,m:dust.li@linux.alibaba.com,m:sidraya@linux.ibm.com,m:wenjia@linux.ibm.com,m:mjambigi@linux.ibm.com,m:tonylu@linux.alibaba.com,m:guwen@linux.alibaba.com,m:jmaloy@redhat.com,m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:vikas.gupta@broadcom.com,m:rajashekar.hudumula@broadcom.com,m:justin.chen@broadcom.com,m:bhargava.marreddy@broadcom.com,m:arnd
 @arndb.de,m:nb@tipi-net.de,m:florian.fainelli@broadcom.com,m:hkallweit1@gmail.com,m:krzk@kernel.org,m:rmk+kernel@armlinux.org.uk,m:me@ziyao.cc,m:siyanteng@cqsoftware.com.cn,m:maxime.chevallier@bootlin.com,m:julianbraha@gmail.com,m:a0987203069@gmail.com,m:weishangjuan@eswincomputing.com,m:wens@kernel.org,m:inochiama@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER(0.00)[fmancera@suse.de,linux-sctp@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,nvidia.com,suse.de,ziepe.ca,lunn.ch,intel.com,marvell.com,gmail.com,foss.st.com,broadcom.com,kernel.dk,lst.de,grimberg.me,HansenPartnership.com,oracle.com,chelsio.com,zeniv.linux.org.uk,suse.cz,auristor.com,brown.name,talpey.com,mailbox.org,simonwunderlich.de,mandelbit.com,narfation.org,blackwall.org,netfilter.org,strlen.de,nwl.cc,sipsolutions.net,ssi.bg,ovn.org,mojatatu.com,resnulli.us,linux.alibaba.com,linux.ibm.com,secunet.com,gondor.apana.org.au,arndb.de,tipi-net.de,armlinux.org.uk,ziyao.cc,cqsoftware.com.cn,bootlin.com,eswincomputing.com,bp.renesas.com,linux.dev,linuxfoundation.org,alyssa.is,vger.kernel.org,lists.osuosl.org,corigine.com,amd.com,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev,lists.open-mesh.org,openvswitch.org,oss.oracle.com,lists.sourceforge.net];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,linux-sctp@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_GT_50(0.00)[135];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp,netdev,kernel];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.de:from_mime,suse.de:email,suse.de:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D6855743683

Historically, the IPv4 protocol has been linked to the core INET
subsystem. Because shared infrastructure like the TCP/UDP engine,
routing or INET hashtables live inside net/ipv4/, it has been impossible
to compile a kernel with only IPv6 support.

This patch introduces the CONFIG_IPV4 Kconfig symbol, which is set to
'def_bool y' for now. This does not allow to completely disable the
IPv4 stack yet but it lays the necessary build-system work for that
goal.

In addition, multiple subsystems Kconfig symbols across networking
features like tunnels, drivers and filesystems have been adjusted to
depend on IPv4. Keep on mind that follow-up work is required to convert
the Kconfig symbol to bool and remove the dependency on IPv4 where it
makes sense.

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 drivers/infiniband/Kconfig                    |  2 +-
 drivers/net/Kconfig                           | 24 ++++++++++---------
 drivers/net/ethernet/broadcom/Kconfig         |  2 ++
 drivers/net/ethernet/chelsio/Kconfig          |  2 +-
 drivers/net/ethernet/intel/Kconfig            |  2 ++
 drivers/net/ethernet/marvell/prestera/Kconfig |  1 +
 .../net/ethernet/mellanox/mlx5/core/Kconfig   |  3 ++-
 drivers/net/ethernet/mellanox/mlxsw/Kconfig   |  1 +
 drivers/net/ethernet/netronome/Kconfig        |  1 +
 drivers/net/ethernet/qlogic/Kconfig           |  2 ++
 drivers/net/ethernet/sfc/Kconfig              |  1 +
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  1 +
 drivers/net/ethernet/via/Kconfig              |  1 +
 drivers/net/ppp/Kconfig                       |  1 +
 .../broadcom/brcm80211/brcmfmac/Kconfig       |  1 +
 drivers/net/wireless/intel/iwlwifi/Kconfig    |  1 +
 drivers/nvme/host/Kconfig                     |  2 +-
 drivers/nvme/target/Kconfig                   |  2 +-
 drivers/scsi/bnx2fc/Kconfig                   |  1 +
 drivers/scsi/bnx2i/Kconfig                    |  1 +
 drivers/scsi/cxgbi/cxgb3i/Kconfig             |  2 +-
 drivers/scsi/cxgbi/cxgb4i/Kconfig             |  2 +-
 drivers/target/iscsi/Kconfig                  |  2 +-
 fs/Kconfig                                    |  1 +
 fs/afs/Kconfig                                |  2 +-
 fs/nfs/Kconfig                                |  2 +-
 fs/nfsd/Kconfig                               |  2 +-
 net/Kconfig                                   |  6 ++---
 net/batman-adv/Kconfig                        |  1 +
 net/bridge/Kconfig                            |  3 ++-
 net/bridge/netfilter/Kconfig                  |  6 ++---
 net/ipv4/Kconfig                              | 21 +++++++++++++---
 net/ipv4/Makefile                             | 21 ++++++++--------
 net/ipv4/netfilter/Kconfig                    |  2 +-
 net/ipv6/Kconfig                              | 17 +++++++++----
 net/ipv6/netfilter/Kconfig                    |  2 +-
 net/l2tp/Kconfig                              |  2 +-
 net/mac80211/Kconfig                          |  2 +-
 net/mpls/Kconfig                              |  1 +
 net/mptcp/Kconfig                             |  2 +-
 net/netfilter/Kconfig                         |  2 +-
 net/netfilter/ipset/Kconfig                   |  2 +-
 net/netfilter/ipvs/Kconfig                    |  2 +-
 net/openvswitch/Kconfig                       |  2 +-
 net/packet/Kconfig                            |  1 +
 net/rds/Kconfig                               |  2 +-
 net/rxrpc/Kconfig                             |  2 +-
 net/sched/Kconfig                             |  2 +-
 net/sctp/Kconfig                              |  2 +-
 net/smc/Kconfig                               |  2 +-
 net/sunrpc/Kconfig                            |  2 +-
 net/tipc/Kconfig                              |  2 +-
 net/xfrm/Kconfig                              | 12 ++++++++--
 53 files changed, 121 insertions(+), 65 deletions(-)

diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
index 086195758a8a..e9302002b6ea 100644
--- a/drivers/infiniband/Kconfig
+++ b/drivers/infiniband/Kconfig
@@ -3,7 +3,7 @@ menuconfig INFINIBAND
 	tristate "InfiniBand support"
 	depends on HAS_IOMEM && HAS_DMA
 	depends on NET
-	depends on INET
+	depends on INET && IPV4
 	depends on !ALPHA
 	select DMA_SHARED_BUFFER
 	select IRQ_POLL
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index ff79c466712d..8e66b3015698 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -40,7 +40,7 @@ if NET_CORE
 
 config BONDING
 	tristate "Bonding driver support"
-	depends on INET
+	depends on INET && IPV4
 	depends on TLS || TLS_DEVICE=n
 	help
 	  Say 'Y' or 'M' if you wish to be able to 'bond' multiple Ethernet
@@ -73,7 +73,7 @@ config DUMMY
 
 config WIREGUARD
 	tristate "WireGuard secure network tunnel"
-	depends on NET && INET
+	depends on NET && INET && IPV4
 	select NET_UDP_TUNNEL
 	select DST_CACHE
 	select CRYPTO_LIB_CURVE25519
@@ -102,7 +102,7 @@ config WIREGUARD_DEBUG
 
 config OVPN
 	tristate "OpenVPN data channel offload"
-	depends on NET && INET
+	depends on NET && INET && IPV4
 	select DST_CACHE
 	select NET_UDP_TUNNEL
 	select CRYPTO
@@ -164,6 +164,7 @@ source "drivers/net/team/Kconfig"
 
 config MACVLAN
 	tristate "MAC-VLAN support"
+	depends on IPV4
 	help
 	  This allows one to create virtual interfaces that map packets to
 	  or from specific MAC addresses to a particular interface.
@@ -198,7 +199,7 @@ config IPVLAN_L3S
 
 config IPVLAN
 	tristate "IP-VLAN support"
-	depends on INET
+	depends on INET && IPV4
 	help
 	  This allows one to create virtual devices off of a main interface
 	  and packets will be delivered based on the dest L3 (IPv6/IPv4 addr)
@@ -229,7 +230,7 @@ config IPVTAP
 
 config VXLAN
 	tristate "Virtual eXtensible Local Area Network (VXLAN)"
-	depends on INET
+	depends on INET && IPV4
 	select NET_UDP_TUNNEL
 	select GRO_CELLS
 	help
@@ -244,7 +245,7 @@ config VXLAN
 
 config GENEVE
 	tristate "Generic Network Virtualization Encapsulation"
-	depends on INET
+	depends on INET && IPV4
 	select NET_UDP_TUNNEL
 	select GRO_CELLS
 	help
@@ -259,7 +260,7 @@ config GENEVE
 
 config BAREUDP
 	tristate "Bare UDP Encapsulation"
-	depends on INET
+	depends on INET && IPV4
 	select NET_UDP_TUNNEL
 	select GRO_CELLS
 	help
@@ -271,7 +272,7 @@ config BAREUDP
 
 config GTP
 	tristate "GPRS Tunneling Protocol datapath (GTP-U)"
-	depends on INET
+	depends on INET && IPV4
 	select NET_UDP_TUNNEL
 	help
 	  This allows one to create gtp virtual interfaces that provide
@@ -288,7 +289,7 @@ config GTP
 
 config PFCP
 	tristate "Packet Forwarding Control Protocol (PFCP)"
-	depends on INET
+	depends on INET && IPV4
 	select NET_UDP_TUNNEL
 	help
 	  This allows one to create PFCP virtual interfaces that allows to
@@ -301,7 +302,7 @@ config PFCP
 
 config AMT
 	tristate "Automatic Multicast Tunneling (AMT)"
-	depends on INET && IP_MULTICAST
+	depends on INET && IP_MULTICAST && IPV4
 	select NET_UDP_TUNNEL
 	help
 	  This allows one to create AMT(Automatic Multicast Tunneling)
@@ -471,6 +472,7 @@ config NETKIT
 
 config NET_VRF
 	tristate "Virtual Routing and Forwarding (Lite)"
+	depends on IPV4
 	depends on IP_MULTIPLE_TABLES
 	depends on NET_L3_MASTER_DEV
 	depends on IPV6_MULTIPLE_TABLES || IPV6=n
@@ -604,7 +606,7 @@ source "drivers/net/hyperv/Kconfig"
 config NETDEVSIM
 	tristate "Simulated networking device"
 	depends on DEBUG_FS
-	depends on INET
+	depends on INET && IPV4
 	depends on PSAMPLE || PSAMPLE=n
 	depends on PTP_1588_CLOCK_MOCK || PTP_1588_CLOCK_MOCK=n
 	select NET_DEVLINK
diff --git a/drivers/net/ethernet/broadcom/Kconfig b/drivers/net/ethernet/broadcom/Kconfig
index f0bac0dd1439..02469b439127 100644
--- a/drivers/net/ethernet/broadcom/Kconfig
+++ b/drivers/net/ethernet/broadcom/Kconfig
@@ -97,6 +97,7 @@ config BNX2
 
 config CNIC
 	tristate "QLogic CNIC support"
+	depends on IPV4
 	depends on PCI
 	select BNX2
 	select UIO
@@ -208,6 +209,7 @@ config BNXT
 	tristate "Broadcom NetXtreme-C/E support"
 	depends on PCI
 	depends on PTP_1588_CLOCK_OPTIONAL
+	depends on IPV4
 	select FW_LOADER
 	select CRC32
 	select NET_DEVLINK
diff --git a/drivers/net/ethernet/chelsio/Kconfig b/drivers/net/ethernet/chelsio/Kconfig
index 96d7779cd2f0..c738820688e0 100644
--- a/drivers/net/ethernet/chelsio/Kconfig
+++ b/drivers/net/ethernet/chelsio/Kconfig
@@ -48,7 +48,7 @@ config CHELSIO_T1_1G
 
 config CHELSIO_T3
 	tristate "Chelsio Communications T3 10Gb Ethernet support"
-	depends on PCI && INET
+	depends on PCI && INET && IPV4
 	select FW_LOADER
 	select MDIO
 	help
diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
index 288fa8ce53af..d975e41a2b68 100644
--- a/drivers/net/ethernet/intel/Kconfig
+++ b/drivers/net/ethernet/intel/Kconfig
@@ -193,6 +193,7 @@ config IXGBE_DCB
 
 config IXGBE_IPSEC
 	bool "IPSec XFRM cryptography-offload acceleration"
+	depends on IPV4
 	depends on IXGBE
 	depends on XFRM_OFFLOAD
 	default y
@@ -219,6 +220,7 @@ config IXGBEVF
 
 config IXGBEVF_IPSEC
 	bool "IPSec XFRM cryptography-offload acceleration"
+	depends on IPV4
 	depends on IXGBEVF
 	depends on XFRM_OFFLOAD
 	default y
diff --git a/drivers/net/ethernet/marvell/prestera/Kconfig b/drivers/net/ethernet/marvell/prestera/Kconfig
index f2f7663c3d10..4c7486c7e706 100644
--- a/drivers/net/ethernet/marvell/prestera/Kconfig
+++ b/drivers/net/ethernet/marvell/prestera/Kconfig
@@ -7,6 +7,7 @@ config PRESTERA
 	tristate "Marvell Prestera Switch ASICs support"
 	depends on NET_SWITCHDEV && VLAN_8021Q
 	depends on BRIDGE || BRIDGE=n
+	depends on IPV4
 	select NET_DEVLINK
 	select PHYLINK
 	help
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Kconfig b/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
index 925ee25d05b4..86b0884968b6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
@@ -12,6 +12,7 @@ config MLX5_CORE
 	depends on PTP_1588_CLOCK_OPTIONAL
 	depends on PCI_HYPERV_INTERFACE || !PCI_HYPERV_INTERFACE
 	depends on HWMON || !HWMON
+	depends on IPV4
 	help
 	  Core driver for low level functionality of the ConnectX-4 and
 	  Connect-IB cards by Mellanox Technologies.
@@ -28,7 +29,7 @@ config MLX5_FPGA
 
 config MLX5_CORE_EN
 	bool "Mellanox 5th generation network adapters (ConnectX series) Ethernet support"
-	depends on NETDEVICES && ETHERNET && INET && PCI && MLX5_CORE
+	depends on NETDEVICES && ETHERNET && INET && PCI && MLX5_CORE && IPV4
 	select PAGE_POOL
 	select PAGE_POOL_STATS
 	select DIMLIB
diff --git a/drivers/net/ethernet/mellanox/mlxsw/Kconfig b/drivers/net/ethernet/mellanox/mlxsw/Kconfig
index 2229a2694aa5..d12c33044a1d 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/Kconfig
+++ b/drivers/net/ethernet/mellanox/mlxsw/Kconfig
@@ -53,6 +53,7 @@ config MLXSW_I2C
 
 config MLXSW_SPECTRUM
 	tristate "Mellanox Technologies Spectrum family support"
+	depends on IPV4
 	depends on MLXSW_CORE && MLXSW_PCI && NET_SWITCHDEV && VLAN_8021Q
 	depends on PSAMPLE || PSAMPLE=n
 	depends on BRIDGE || BRIDGE=n
diff --git a/drivers/net/ethernet/netronome/Kconfig b/drivers/net/ethernet/netronome/Kconfig
index d115d16d4649..2ac3f89e1f26 100644
--- a/drivers/net/ethernet/netronome/Kconfig
+++ b/drivers/net/ethernet/netronome/Kconfig
@@ -18,6 +18,7 @@ if NET_VENDOR_NETRONOME
 
 config NFP
 	tristate "Netronome(R) NFP4000/NFP6000 NIC driver"
+	depends on IPV4
 	depends on PCI_MSI
 	depends on VXLAN || VXLAN=n
 	depends on TLS && TLS_DEVICE || TLS_DEVICE=n
diff --git a/drivers/net/ethernet/qlogic/Kconfig b/drivers/net/ethernet/qlogic/Kconfig
index 1203353238e5..d198f6add1a8 100644
--- a/drivers/net/ethernet/qlogic/Kconfig
+++ b/drivers/net/ethernet/qlogic/Kconfig
@@ -29,6 +29,7 @@ config QLA3XXX
 config QLCNIC
 	tristate "QLOGIC QLCNIC 1/10Gb Converged Ethernet NIC Support"
 	depends on PCI
+	depends on IPV4
 	select FW_LOADER
 	help
 	  This driver supports QLogic QLE8240 and QLE8242 Converged Ethernet
@@ -68,6 +69,7 @@ config QLCNIC_HWMON
 
 config NETXEN_NIC
 	tristate "NetXen Multi port (1/10) Gigabit Ethernet NIC"
+	depends on IPV4
 	depends on PCI
 	select FW_LOADER
 	help
diff --git a/drivers/net/ethernet/sfc/Kconfig b/drivers/net/ethernet/sfc/Kconfig
index 979f2801e2a8..d2e32e8ffce8 100644
--- a/drivers/net/ethernet/sfc/Kconfig
+++ b/drivers/net/ethernet/sfc/Kconfig
@@ -18,6 +18,7 @@ if NET_VENDOR_SOLARFLARE
 
 config SFC
 	tristate "Solarflare SFC9100/EF100-family support"
+	depends on IPV4
 	depends on PCI
 	depends on PTP_1588_CLOCK_OPTIONAL
 	select MDIO
diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index e3dd5adda5ac..4ac59a43d71c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config STMMAC_ETH
 	tristate "STMicroelectronics Multi-Gigabit Ethernet driver"
+	depends on IPV4
 	depends on HAS_IOMEM && HAS_DMA
 	depends on PTP_1588_CLOCK_OPTIONAL
 	depends on ETHTOOL_NETLINK
diff --git a/drivers/net/ethernet/via/Kconfig b/drivers/net/ethernet/via/Kconfig
index 00773f5e4d7e..a62eb98f2e27 100644
--- a/drivers/net/ethernet/via/Kconfig
+++ b/drivers/net/ethernet/via/Kconfig
@@ -45,6 +45,7 @@ config VIA_RHINE_MMIO
 
 config VIA_VELOCITY
 	tristate "VIA Velocity support"
+	depends on IPV4
 	depends on (PCI || (OF_ADDRESS && OF_IRQ))
 	depends on HAS_DMA
 	select CRC32
diff --git a/drivers/net/ppp/Kconfig b/drivers/net/ppp/Kconfig
index 4047f13b83dc..16826da75d1e 100644
--- a/drivers/net/ppp/Kconfig
+++ b/drivers/net/ppp/Kconfig
@@ -160,6 +160,7 @@ config PPPOE_HASH_BITS
 
 config PPTP
 	tristate "PPP over IPv4 (PPTP)"
+	depends on IPV4
 	depends on NET_IPGRE_DEMUX
 	select PPPOX
 	help
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/Kconfig b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/Kconfig
index 32794c1eca23..95d685f165ea 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/Kconfig
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/Kconfig
@@ -1,6 +1,7 @@
 config BRCMFMAC
 	tristate "Broadcom FullMAC WLAN driver"
 	depends on CFG80211
+	depends on IPV4
 	select BRCMUTIL
 	help
 	  This module adds support for wireless adapters based on Broadcom
diff --git a/drivers/net/wireless/intel/iwlwifi/Kconfig b/drivers/net/wireless/intel/iwlwifi/Kconfig
index 153a8368b412..d2efd96cd513 100644
--- a/drivers/net/wireless/intel/iwlwifi/Kconfig
+++ b/drivers/net/wireless/intel/iwlwifi/Kconfig
@@ -2,6 +2,7 @@
 config IWLWIFI
 	tristate "Intel Wireless WiFi Next Gen AGN - Wireless-N/Advanced-N/Ultimate-N (iwlwifi) "
 	depends on PCI && HAS_IOMEM && CFG80211
+	depends on IPV4
 	depends on IWLMEI || !IWLMEI
 	select FW_LOADER
 	help
diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index 31974c7dd20c..6e119cf475de 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -82,7 +82,7 @@ config NVME_FC
 
 config NVME_TCP
 	tristate "NVM Express over Fabrics TCP host driver"
-	depends on INET
+	depends on INET && IPV4
 	depends on BLOCK
 	select CRC32
 	select NET_CRC32C
diff --git a/drivers/nvme/target/Kconfig b/drivers/nvme/target/Kconfig
index 69bde270115e..f731a043f6a9 100644
--- a/drivers/nvme/target/Kconfig
+++ b/drivers/nvme/target/Kconfig
@@ -86,7 +86,7 @@ config NVME_TARGET_FCLOOP
 
 config NVME_TARGET_TCP
 	tristate "NVMe over Fabrics TCP target support"
-	depends on INET
+	depends on INET && IPV4
 	depends on NVME_TARGET
 	help
 	  This enables the NVMe TCP target support, which allows exporting NVMe
diff --git a/drivers/scsi/bnx2fc/Kconfig b/drivers/scsi/bnx2fc/Kconfig
index d12eeb13384a..d5065b8fdea9 100644
--- a/drivers/scsi/bnx2fc/Kconfig
+++ b/drivers/scsi/bnx2fc/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config SCSI_BNX2X_FCOE
 	tristate "QLogic FCoE offload support"
+	depends on IPV4
 	depends on PCI
 	depends on LIBFC
 	depends on LIBFCOE
diff --git a/drivers/scsi/bnx2i/Kconfig b/drivers/scsi/bnx2i/Kconfig
index e649a04fab1d..0458e4811731 100644
--- a/drivers/scsi/bnx2i/Kconfig
+++ b/drivers/scsi/bnx2i/Kconfig
@@ -2,6 +2,7 @@
 config SCSI_BNX2_ISCSI
 	tristate "QLogic NetXtreme II iSCSI support"
 	depends on NET
+	depends on IPV4
 	depends on PCI
 	select SCSI_ISCSI_ATTRS
 	select NETDEVICES
diff --git a/drivers/scsi/cxgbi/cxgb3i/Kconfig b/drivers/scsi/cxgbi/cxgb3i/Kconfig
index 143e881ec77e..abb4a462cb37 100644
--- a/drivers/scsi/cxgbi/cxgb3i/Kconfig
+++ b/drivers/scsi/cxgbi/cxgb3i/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config SCSI_CXGB3_ISCSI
 	tristate "Chelsio T3 iSCSI support"
-	depends on PCI && INET
+	depends on PCI && INET && IPV4
 	select NETDEVICES
 	select ETHERNET
 	select NET_VENDOR_CHELSIO
diff --git a/drivers/scsi/cxgbi/cxgb4i/Kconfig b/drivers/scsi/cxgbi/cxgb4i/Kconfig
index dd1c8ff36b00..04b3e7b053dc 100644
--- a/drivers/scsi/cxgbi/cxgb4i/Kconfig
+++ b/drivers/scsi/cxgbi/cxgb4i/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config SCSI_CXGB4_ISCSI
 	tristate "Chelsio T4 iSCSI support"
-	depends on PCI && INET
+	depends on PCI && INET && IPV4
 	depends on PTP_1588_CLOCK_OPTIONAL
 	depends on THERMAL || !THERMAL
 	depends on ETHERNET
diff --git a/drivers/target/iscsi/Kconfig b/drivers/target/iscsi/Kconfig
index 70d76f3dd693..362edff80c15 100644
--- a/drivers/target/iscsi/Kconfig
+++ b/drivers/target/iscsi/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config ISCSI_TARGET
 	tristate "SCSI Target Mode Stack"
-	depends on INET
+	depends on INET && IPV4
 	select CRC32
 	select CRYPTO
 	select CRYPTO_HASH
diff --git a/fs/Kconfig b/fs/Kconfig
index cf6ae64776e6..20199c1cc93a 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -360,6 +360,7 @@ config GRACE_PERIOD
 
 config LOCKD
 	tristate
+	depends on IPV4
 	depends on FILE_LOCKING
 	select CRC32
 	select GRACE_PERIOD
diff --git a/fs/afs/Kconfig b/fs/afs/Kconfig
index 682bd8ec2c10..e7ed46426f81 100644
--- a/fs/afs/Kconfig
+++ b/fs/afs/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config AFS_FS
 	tristate "Andrew File System support (AFS)"
-	depends on INET
+	depends on INET && IPV4
 	select AF_RXRPC
 	select DNS_RESOLVER
 	select NETFS_SUPPORT
diff --git a/fs/nfs/Kconfig b/fs/nfs/Kconfig
index 6bb30543eff0..52efd3664d21 100644
--- a/fs/nfs/Kconfig
+++ b/fs/nfs/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config NFS_FS
 	tristate "NFS client support"
-	depends on INET && FILE_LOCKING && MULTIUSER
+	depends on INET && FILE_LOCKING && MULTIUSER && IPV4
 	select CRC32
 	select LOCKD
 	select SUNRPC
diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
index ffb76761d6a8..153a9918214d 100644
--- a/fs/nfsd/Kconfig
+++ b/fs/nfsd/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config NFSD
 	tristate "NFS server support"
-	depends on INET
+	depends on INET && IPV4
 	depends on FILE_LOCKING
 	depends on FSNOTIFY
 	select CRC32
diff --git a/net/Kconfig b/net/Kconfig
index e38477393551..27de9e69b5f7 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -385,7 +385,7 @@ menu "Network testing"
 
 config NET_PKTGEN
 	tristate "Packet Generator (USE WITH CAUTION)"
-	depends on INET && PROC_FS
+	depends on INET && IPV4 && PROC_FS
 	help
 	  This module will inject preconfigured packets, at a configurable
 	  rate, out of a given interface.  It is used for network interface
@@ -452,7 +452,7 @@ config LWTUNNEL
 
 config LWTUNNEL_BPF
 	bool "Execute BPF program as route nexthop action"
-	depends on LWTUNNEL && INET
+	depends on LWTUNNEL && INET && IPV4
 	default y if LWTUNNEL=y
 	help
 	  Allows to run BPF programs as a nexthop action following a route
@@ -474,7 +474,7 @@ config NET_IEEE8021Q_HELPERS
 
 config NET_SELFTESTS
 	def_tristate PHYLIB
-	depends on PHYLIB && INET
+	depends on PHYLIB && INET && IPV4
 
 config NET_SOCK_MSG
 	bool
diff --git a/net/batman-adv/Kconfig b/net/batman-adv/Kconfig
index 58c408b7a7d9..60ad4b09be6e 100644
--- a/net/batman-adv/Kconfig
+++ b/net/batman-adv/Kconfig
@@ -9,6 +9,7 @@
 
 config BATMAN_ADV
 	tristate "B.A.T.M.A.N. Advanced Meshing Protocol"
+	depends on IPV4
 	select CRC32
 	help
 	  B.A.T.M.A.N. (better approach to mobile ad-hoc networking) is
diff --git a/net/bridge/Kconfig b/net/bridge/Kconfig
index 318715c8fc9b..421892a03129 100644
--- a/net/bridge/Kconfig
+++ b/net/bridge/Kconfig
@@ -7,6 +7,7 @@ config BRIDGE
 	tristate "802.1d Ethernet Bridging"
 	select LLC
 	select STP
+	depends on IPV4
 	help
 	  If you say Y here, then your Linux box will be able to act as an
 	  Ethernet bridge, which means that the different Ethernet segments it
@@ -36,7 +37,7 @@ config BRIDGE
 config BRIDGE_IGMP_SNOOPING
 	bool "IGMP/MLD snooping"
 	depends on BRIDGE
-	depends on INET
+	depends on INET && IPV4
 	default y
 	help
 	  If you say Y here, then the Ethernet bridge will be able selectively
diff --git a/net/bridge/netfilter/Kconfig b/net/bridge/netfilter/Kconfig
index 4fd5a6ea26b4..003f055f8cfe 100644
--- a/net/bridge/netfilter/Kconfig
+++ b/net/bridge/netfilter/Kconfig
@@ -4,7 +4,7 @@
 #
 #
 menuconfig NF_TABLES_BRIDGE
-	depends on BRIDGE && NETFILTER && NF_TABLES
+	depends on BRIDGE && NETFILTER && NF_TABLES && IPV4
 	select NETFILTER_FAMILY_BRIDGE
 	tristate "Ethernet Bridge nf_tables support"
 
@@ -43,7 +43,7 @@ config NF_CONNTRACK_BRIDGE
 config BRIDGE_NF_EBTABLES_LEGACY
 	tristate "Legacy EBTABLES support"
 	depends on BRIDGE && NETFILTER_XTABLES_LEGACY
-	depends on NETFILTER_XTABLES
+	depends on NETFILTER_XTABLES && IPV4
 	default	n
 	help
 	 Legacy ebtables packet/frame classifier.
@@ -52,7 +52,7 @@ config BRIDGE_NF_EBTABLES_LEGACY
 
 menuconfig BRIDGE_NF_EBTABLES
 	tristate "Ethernet Bridge tables (ebtables) support"
-	depends on BRIDGE && NETFILTER && NETFILTER_XTABLES
+	depends on BRIDGE && NETFILTER && NETFILTER_XTABLES && IPV4
 	select NETFILTER_FAMILY_BRIDGE
 	help
 	  ebtables is a general, extensible frame/packet identification
diff --git a/net/ipv4/Kconfig b/net/ipv4/Kconfig
index 301b47660305..51bf05d9770c 100644
--- a/net/ipv4/Kconfig
+++ b/net/ipv4/Kconfig
@@ -2,6 +2,9 @@
 #
 # IP configuration
 #
+config IPV4
+	def_bool y
+
 config IP_MULTICAST
 	bool "IP: multicasting"
 	help
@@ -62,7 +65,7 @@ config IP_FIB_TRIE_STATS
 
 config IP_MULTIPLE_TABLES
 	bool "IP: policy routing"
-	depends on IP_ADVANCED_ROUTER
+	depends on IPV4 && IP_ADVANCED_ROUTER
 	select FIB_RULES
 	help
 	  Normally, a router decides what to do with a received packet based
@@ -105,6 +108,7 @@ config IP_ROUTE_CLASSID
 
 config IP_PNP
 	bool "IP: kernel level autoconfiguration"
+	depends on IPV4
 	help
 	  This enables automatic configuration of IP addresses of devices and
 	  of the routing table during kernel boot, based on either information
@@ -161,6 +165,7 @@ config IP_PNP_RARP
 
 config NET_IPIP
 	tristate "IP: tunneling"
+	depends on IPV4
 	select INET_TUNNEL
 	select NET_IP_TUNNEL
 	help
@@ -185,12 +190,14 @@ config NET_IPGRE_DEMUX
 
 config NET_IP_TUNNEL
 	tristate
+	depends on IPV4
 	select DST_CACHE
 	select GRO_CELLS
 	default n
 
 config NET_IPGRE
 	tristate "IP: GRE tunnels over IP"
+	depends on IPV4
 	depends on NET_IPGRE_DEMUX
 	select NET_IP_TUNNEL
 	help
@@ -219,7 +226,7 @@ config IP_MROUTE_COMMON
 
 config IP_MROUTE
 	bool "IP: multicast routing"
-	depends on IP_MULTICAST
+	depends on IP_MULTICAST && IPV4
 	select IP_MROUTE_COMMON
 	help
 	  This is used if you want your machine to act as a router for IP
@@ -267,6 +274,7 @@ config IP_PIMSM_V2
 
 config SYN_COOKIES
 	bool "IP: TCP syncookie support"
+	depends on IPV4
 	help
 	  Normal TCP/IP networking is open to an attack known as "SYN
 	  flooding". This denial-of-service attack prevents legitimate remote
@@ -303,6 +311,7 @@ config SYN_COOKIES
 
 config NET_IPVTI
 	tristate "Virtual (secure) IP: tunneling"
+	depends on IPV4
 	select INET_TUNNEL
 	select NET_IP_TUNNEL
 	select XFRM
@@ -315,11 +324,13 @@ config NET_IPVTI
 
 config NET_UDP_TUNNEL
 	tristate
+	depends on IPV4
 	select NET_IP_TUNNEL
 	default n
 
 config NET_FOU
 	tristate "IP: Foo (IP protocols) over UDP"
+	depends on IPV4
 	select NET_UDP_TUNNEL
 	help
 	  Foo over UDP allows any IP protocol to be directly encapsulated
@@ -338,6 +349,7 @@ config NET_FOU_IP_TUNNELS
 
 config INET_AH
 	tristate "IP: AH transformation"
+	depends on IPV4
 	select XFRM_AH
 	help
 	  Support for IPsec AH (Authentication Header).
@@ -353,6 +365,7 @@ config INET_AH
 
 config INET_ESP
 	tristate "IP: ESP transformation"
+	depends on IPV4
 	select XFRM_ESP
 	help
 	  Support for IPsec ESP (Encapsulating Security Payload).
@@ -393,6 +406,7 @@ config INET_ESPINTCP
 
 config INET_IPCOMP
 	tristate "IP: IPComp transformation"
+	depends on IPV4
 	select INET_XFRM_TUNNEL
 	select XFRM_IPCOMP
 	help
@@ -747,7 +761,7 @@ config TCP_AO
 	select CRYPTO_LIB_SHA1
 	select CRYPTO_LIB_SHA256
 	select CRYPTO_LIB_UTILS
-	depends on 64BIT # seq-number extension needs WRITE_ONCE(u64)
+	depends on IPV4 && 64BIT # seq-number extension needs WRITE_ONCE(u64)
 	help
 	  TCP-AO specifies the use of stronger Message Authentication Codes (MACs),
 	  protects against replays for long-lived TCP connections, and
@@ -758,6 +772,7 @@ config TCP_AO
 
 config TCP_MD5SIG
 	bool "TCP: MD5 Signature Option support (RFC2385)"
+	depends on IPV4
 	select CRYPTO_LIB_MD5
 	select CRYPTO_LIB_UTILS
 	help
diff --git a/net/ipv4/Makefile b/net/ipv4/Makefile
index 06e21c26b76f..8b148be79fa4 100644
--- a/net/ipv4/Makefile
+++ b/net/ipv4/Makefile
@@ -3,18 +3,17 @@
 # Makefile for the Linux TCP/IP (INET) layer.
 #
 
-obj-y     := route.o inetpeer.o protocol.o \
-	     ip_input.o ip_fragment.o ip_forward.o ip_options.o \
-	     ip_output.o ip_sockglue.o inet_hashtables.o \
-	     inet_timewait_sock.o inet_connection_sock.o \
-	     tcp.o tcp_input.o tcp_output.o tcp_timer.o tcp_ipv4.o \
+obj-y     := inetpeer.o protocol.o inet_hashtables.o inet_timewait_sock.o \
+	     inet_connection_sock.o tcp.o tcp_input.o tcp_output.o tcp_timer.o \
 	     tcp_minisocks.o tcp_cong.o tcp_metrics.o tcp_fastopen.o \
-	     tcp_recovery.o tcp_ulp.o \
-	     tcp_offload.o tcp_plb.o datagram.o raw.o udp.o \
-	     udp_offload.o arp.o icmp.o devinet.o af_inet.o igmp.o \
-	     fib_frontend.o fib_semantics.o fib_trie.o fib_notifier.o \
-	     inet_fragment.o ping.o ip_tunnel_core.o gre_offload.o \
-	     metrics.o netlink.o nexthop.o udp_tunnel_stub.o
+	     tcp_recovery.o tcp_ulp.o tcp_offload.o tcp_plb.o raw.o udp.o \
+	     udp_offload.o af_inet.o inet_fragment.o ping.o ip_tunnel_core.o \
+	     gre_offload.o metrics.o netlink.o nexthop.o udp_tunnel_stub.o
+
+obj-$(CONFIG_IPV4) += route.o ip_input.o ip_fragment.o ip_forward.o ip_options.o \
+		      ip_sockglue.o tcp_ipv4.o datagram.o icmp.o arp.o devinet.o \
+		      igmp.o fib_notifier.o ip_output.o fib_frontend.o \
+		      fib_semantics.o fib_trie.o
 
 obj-$(CONFIG_NET_IP_TUNNEL) += ip_tunnel.o
 obj-$(CONFIG_SYSCTL) += sysctl_net_ipv4.o
diff --git a/net/ipv4/netfilter/Kconfig b/net/ipv4/netfilter/Kconfig
index 7dc9772fe2d8..ab4fa6a6d453 100644
--- a/net/ipv4/netfilter/Kconfig
+++ b/net/ipv4/netfilter/Kconfig
@@ -4,7 +4,7 @@
 #
 
 menu "IP: Netfilter Configuration"
-	depends on INET && NETFILTER
+	depends on INET && NETFILTER && IPV4
 
 config NF_DEFRAG_IPV4
 	tristate
diff --git a/net/ipv6/Kconfig b/net/ipv6/Kconfig
index c3806c6ac96f..f83efc1505cc 100644
--- a/net/ipv6/Kconfig
+++ b/net/ipv6/Kconfig
@@ -47,6 +47,7 @@ config IPV6_OPTIMISTIC_DAD
 config INET6_AH
 	tristate "IPv6: AH transformation"
 	select XFRM_AH
+	depends on IPV4
 	help
 	  Support for IPsec AH (Authentication Header).
 
@@ -61,6 +62,7 @@ config INET6_AH
 
 config INET6_ESP
 	tristate "IPv6: ESP transformation"
+	depends on IPV4
 	select XFRM_ESP
 	help
 	  Support for IPsec ESP (Encapsulating Security Payload).
@@ -101,6 +103,7 @@ config INET6_ESPINTCP
 
 config INET6_IPCOMP
 	tristate "IPv6: IPComp transformation"
+	depends on IPV4
 	select INET6_XFRM_TUNNEL
 	select XFRM_IPCOMP
 	help
@@ -111,6 +114,7 @@ config INET6_IPCOMP
 
 config IPV6_MIP6
 	tristate "IPv6: Mobility"
+	depends on IPV4
 	select XFRM
 	help
 	  Support for IPv6 Mobility described in RFC 3775.
@@ -119,6 +123,7 @@ config IPV6_MIP6
 
 config IPV6_ILA
 	tristate "IPv6: Identifier Locator Addressing (ILA)"
+	depends on IPV4
 	depends on NETFILTER
 	select DST_CACHE
 	select LWTUNNEL
@@ -149,6 +154,7 @@ config INET6_TUNNEL
 
 config IPV6_VTI
 	tristate "Virtual (secure) IPv6: tunneling"
+	depends on IPV4
 	select IPV6_TUNNEL
 	select NET_IP_TUNNEL
 	select XFRM
@@ -161,6 +167,7 @@ config IPV6_VTI
 
 config IPV6_SIT
 	tristate "IPv6: IPv6-in-IPv4 tunnel (SIT driver)"
+	depends on IPV4
 	select INET_TUNNEL
 	select NET_IP_TUNNEL
 	select IPV6_NDISC_NODETYPE
@@ -198,6 +205,7 @@ config IPV6_NDISC_NODETYPE
 
 config IPV6_TUNNEL
 	tristate "IPv6: IP-in-IPv6 tunnel (RFC2473)"
+	depends on IPV4
 	select INET6_TUNNEL
 	select DST_CACHE
 	select GRO_CELLS
@@ -209,6 +217,7 @@ config IPV6_TUNNEL
 
 config IPV6_GRE
 	tristate "IPv6: GRE tunnel"
+	depends on IPV4
 	select IPV6_TUNNEL
 	select NET_IP_TUNNEL
 	depends on NET_IPGRE_DEMUX
@@ -256,7 +265,7 @@ config IPV6_SUBTREES
 
 config IPV6_MROUTE
 	bool "IPv6: multicast routing"
-	depends on IPV6
+	depends on IPV4 && IPV6
 	select IP_MROUTE_COMMON
 	help
 	  Support for IPv6 multicast forwarding.
@@ -285,7 +294,7 @@ config IPV6_PIMSM_V2
 
 config IPV6_SEG6_LWTUNNEL
 	bool "IPv6: Segment Routing Header encapsulation support"
-	depends on IPV6
+	depends on IPV4 && IPV6
 	select LWTUNNEL
 	select DST_CACHE
 	select IPV6_MULTIPLE_TABLES
@@ -316,7 +325,7 @@ config IPV6_SEG6_BPF
 
 config IPV6_RPL_LWTUNNEL
 	bool "IPv6: RPL Source Routing Header support"
-	depends on IPV6
+	depends on IPV4 && IPV6
 	select LWTUNNEL
 	select DST_CACHE
 	help
@@ -327,7 +336,7 @@ config IPV6_RPL_LWTUNNEL
 
 config IPV6_IOAM6_LWTUNNEL
 	bool "IPv6: IOAM Pre-allocated Trace insertion support"
-	depends on IPV6
+	depends on IPV4 && IPV6
 	select LWTUNNEL
 	select DST_CACHE
 	help
diff --git a/net/ipv6/netfilter/Kconfig b/net/ipv6/netfilter/Kconfig
index 81daf82ddc2d..f99a2176bf3d 100644
--- a/net/ipv6/netfilter/Kconfig
+++ b/net/ipv6/netfilter/Kconfig
@@ -4,7 +4,7 @@
 #
 
 menu "IPv6: Netfilter Configuration"
-	depends on INET && IPV6 && NETFILTER
+	depends on INET && IPV6 && NETFILTER && IPV4
 
 # old sockopt interface and eval loop
 config IP6_NF_IPTABLES_LEGACY
diff --git a/net/l2tp/Kconfig b/net/l2tp/Kconfig
index 0de178d5baba..e92cf6d94135 100644
--- a/net/l2tp/Kconfig
+++ b/net/l2tp/Kconfig
@@ -5,7 +5,7 @@
 
 menuconfig L2TP
 	tristate "Layer Two Tunneling Protocol (L2TP)"
-	depends on INET
+	depends on INET && IPV4
 	select NET_UDP_TUNNEL
 	help
 	  Layer Two Tunneling Protocol
diff --git a/net/mac80211/Kconfig b/net/mac80211/Kconfig
index d6bc295e23a1..ec485da28373 100644
--- a/net/mac80211/Kconfig
+++ b/net/mac80211/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config MAC80211
 	tristate "Generic IEEE 802.11 Networking Stack (mac80211)"
-	depends on CFG80211
+	depends on CFG80211 && IPV4
 	select CRYPTO
 	select CRYPTO_LIB_AES_CBC_MACS
 	select CRYPTO_LIB_ARC4
diff --git a/net/mpls/Kconfig b/net/mpls/Kconfig
index d672ab72ab12..541ba192e2a1 100644
--- a/net/mpls/Kconfig
+++ b/net/mpls/Kconfig
@@ -25,6 +25,7 @@ config NET_MPLS_GSO
 
 config MPLS_ROUTING
 	tristate "MPLS: routing support"
+	depends on IPV4
 	depends on NET_IP_TUNNEL || NET_IP_TUNNEL=n
 	depends on PROC_SYSCTL
 	help
diff --git a/net/mptcp/Kconfig b/net/mptcp/Kconfig
index be71fc9b4638..c5b660fdda4c 100644
--- a/net/mptcp/Kconfig
+++ b/net/mptcp/Kconfig
@@ -1,7 +1,7 @@
 
 config MPTCP
 	bool "MPTCP: Multipath TCP"
-	depends on INET
+	depends on INET && IPV4
 	select SKB_EXTENSIONS
 	select CRYPTO_LIB_SHA256
 	select CRYPTO_LIB_UTILS
diff --git a/net/netfilter/Kconfig b/net/netfilter/Kconfig
index 4c04cd8d40a2..3ee9bb726e40 100644
--- a/net/netfilter/Kconfig
+++ b/net/netfilter/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 menu "Core Netfilter Configuration"
-	depends on INET && NETFILTER
+	depends on INET && IPV4 && NETFILTER
 
 config NETFILTER_INGRESS
 	bool "Netfilter ingress support"
diff --git a/net/netfilter/ipset/Kconfig b/net/netfilter/ipset/Kconfig
index 6c4d54758106..e6537c842a45 100644
--- a/net/netfilter/ipset/Kconfig
+++ b/net/netfilter/ipset/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 menuconfig IP_SET
 	tristate "IP set support"
-	depends on INET && NETFILTER
+	depends on INET && IPV4 && NETFILTER
 	select NETFILTER_NETLINK
 	help
 	  This option adds IP set support to the kernel.
diff --git a/net/netfilter/ipvs/Kconfig b/net/netfilter/ipvs/Kconfig
index 7724cb44e6de..fb09218d84d0 100644
--- a/net/netfilter/ipvs/Kconfig
+++ b/net/netfilter/ipvs/Kconfig
@@ -4,7 +4,7 @@
 #
 menuconfig IP_VS
 	tristate "IP virtual server support"
-	depends on INET && NETFILTER
+	depends on INET && NETFILTER && IPV4
 	depends on (NF_CONNTRACK || NF_CONNTRACK=n)
 	help
 	  IP Virtual Server support will let you build a high-performance
diff --git a/net/openvswitch/Kconfig b/net/openvswitch/Kconfig
index e6aaee92dba4..5931c28ef965 100644
--- a/net/openvswitch/Kconfig
+++ b/net/openvswitch/Kconfig
@@ -5,7 +5,7 @@
 
 config OPENVSWITCH
 	tristate "Open vSwitch"
-	depends on INET
+	depends on INET && IPV4
 	depends on !NF_CONNTRACK || \
 		   (NF_CONNTRACK && ((!NF_DEFRAG_IPV6 || NF_DEFRAG_IPV6) && \
 				     (!NF_NAT || NF_NAT) && \
diff --git a/net/packet/Kconfig b/net/packet/Kconfig
index 2997382d597c..00fda9e08cb0 100644
--- a/net/packet/Kconfig
+++ b/net/packet/Kconfig
@@ -5,6 +5,7 @@
 
 config PACKET
 	tristate "Packet socket"
+	depends on IPV4
 	help
 	  The Packet protocol is used by applications which communicate
 	  directly with network devices without an intermediate network
diff --git a/net/rds/Kconfig b/net/rds/Kconfig
index f007730aa2bb..d33cf3d89632 100644
--- a/net/rds/Kconfig
+++ b/net/rds/Kconfig
@@ -2,7 +2,7 @@
 
 config RDS
 	tristate "The Reliable Datagram Sockets Protocol"
-	depends on INET
+	depends on INET && IPV4
 	help
 	  The RDS (Reliable Datagram Sockets) protocol provides reliable,
 	  sequenced delivery of datagrams over Infiniband or TCP.
diff --git a/net/rxrpc/Kconfig b/net/rxrpc/Kconfig
index 2cebb666dc07..2029d2d1065f 100644
--- a/net/rxrpc/Kconfig
+++ b/net/rxrpc/Kconfig
@@ -5,7 +5,7 @@
 
 config AF_RXRPC
 	tristate "RxRPC session sockets"
-	depends on INET
+	depends on INET && IPV4
 	select CRYPTO
 	select CRYPTO_LIB_DES if RXKAD
 	select KEYS
diff --git a/net/sched/Kconfig b/net/sched/Kconfig
index 6ddff028b81a..bb782822c3fb 100644
--- a/net/sched/Kconfig
+++ b/net/sched/Kconfig
@@ -807,7 +807,7 @@ config NET_ACT_SKBEDIT
 
 config NET_ACT_CSUM
 	tristate "Checksum Updating"
-	depends on NET_CLS_ACT && INET
+	depends on NET_CLS_ACT && INET && IPV4
 	select NET_CRC32C
 	help
 	  Say Y here to update some common checksum after some direct
diff --git a/net/sctp/Kconfig b/net/sctp/Kconfig
index fc989a3791b3..eb3e2bf1ec3a 100644
--- a/net/sctp/Kconfig
+++ b/net/sctp/Kconfig
@@ -5,7 +5,7 @@
 
 menuconfig IP_SCTP
 	tristate "The SCTP Protocol"
-	depends on INET
+	depends on INET && IPV4
 	select CRYPTO_LIB_SHA1
 	select CRYPTO_LIB_SHA256
 	select CRYPTO_LIB_UTILS
diff --git a/net/smc/Kconfig b/net/smc/Kconfig
index 277ef504bc26..52005e4bf77d 100644
--- a/net/smc/Kconfig
+++ b/net/smc/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config SMC
 	tristate "SMC socket protocol family"
-	depends on INET && INFINIBAND && DIBS
+	depends on INET && INFINIBAND && DIBS && IPV4
 	help
 	  SMC-R provides a "sockets over RDMA" solution making use of
 	  RDMA over Converged Ethernet (RoCE) technology to upgrade
diff --git a/net/sunrpc/Kconfig b/net/sunrpc/Kconfig
index e7808e5714dc..58e6f6db3100 100644
--- a/net/sunrpc/Kconfig
+++ b/net/sunrpc/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config SUNRPC
 	tristate
-	depends on MULTIUSER
+	depends on MULTIUSER && IPV4
 
 config SUNRPC_GSS
 	tristate
diff --git a/net/tipc/Kconfig b/net/tipc/Kconfig
index 18f62135e47b..869e3fe961f9 100644
--- a/net/tipc/Kconfig
+++ b/net/tipc/Kconfig
@@ -5,7 +5,7 @@
 
 menuconfig TIPC
 	tristate "The TIPC Protocol"
-	depends on INET
+	depends on INET && IPV4
 	help
 	  The Transparent Inter Process Communication (TIPC) protocol is
 	  specially designed for intra cluster communication. This protocol
diff --git a/net/xfrm/Kconfig b/net/xfrm/Kconfig
index 4a62817a88f8..2e4d466c7bd3 100644
--- a/net/xfrm/Kconfig
+++ b/net/xfrm/Kconfig
@@ -4,7 +4,7 @@
 #
 config XFRM
 	bool
-	depends on INET
+	depends on INET && IPV4
 	select GRO_CELLS
 	select SKB_EXTENSIONS
 
@@ -13,6 +13,7 @@ config XFRM_OFFLOAD
 
 config XFRM_ALGO
 	tristate
+	depends on IPV4
 	select XFRM
 	select CRYPTO
 	select CRYPTO_AEAD
@@ -23,6 +24,7 @@ if INET
 config XFRM_USER
 	tristate "Transformation user configuration interface"
 	select XFRM_ALGO
+	depends on IPV4
 	help
 	  Support for Transformation(XFRM) user configuration interface
 	  like IPsec used by native Linux tools.
@@ -42,7 +44,7 @@ config XFRM_USER_COMPAT
 
 config XFRM_INTERFACE
 	tristate "Transformation virtual interface"
-	depends on XFRM && IPV6
+	depends on XFRM && IPV4 && IPV6
 	help
 	  This provides a virtual interface to route IPsec traffic.
 
@@ -83,6 +85,7 @@ config XFRM_STATISTICS
 # RFC 8221 lists as MUST be implemented.
 config XFRM_AH
 	tristate
+	depends on IPV4
 	select XFRM_ALGO
 	select CRYPTO
 	select CRYPTO_HMAC
@@ -92,6 +95,7 @@ config XFRM_AH
 # algorithms that RFC 8221 lists as MUST be implemented.
 config XFRM_ESP
 	tristate
+	depends on IPV4
 	select XFRM_ALGO
 	select CRYPTO
 	select CRYPTO_AES
@@ -105,12 +109,14 @@ config XFRM_ESP
 
 config XFRM_IPCOMP
 	tristate
+	depends on IPV4
 	select XFRM_ALGO
 	select CRYPTO
 	select CRYPTO_DEFLATE
 
 config NET_KEY
 	tristate "PF_KEY sockets (deprecated)"
+	depends on IPV4
 	select XFRM_ALGO
 	help
 	  PF_KEYv2 socket family, compatible to KAME ones.
@@ -140,6 +146,7 @@ config NET_KEY_MIGRATE
 
 config XFRM_IPTFS
 	tristate "IPsec IP-TFS/AGGFRAG (RFC 9347) encapsulation support"
+	depends on IPV4
 	depends on XFRM
 	help
 	  Information on the IP-TFS/AGGFRAG encapsulation can be found
@@ -156,5 +163,6 @@ config XFRM_IPTFS
 
 config XFRM_ESPINTCP
 	bool
+	depends on IPV4
 
 endif # INET
-- 
2.54.0


