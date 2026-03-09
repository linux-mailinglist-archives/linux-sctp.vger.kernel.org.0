Return-Path: <linux-sctp+bounces-978-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDRWMdMurmlrAQIAu9opvQ
	(envelope-from <linux-sctp+bounces-978-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Mon, 09 Mar 2026 03:22:11 +0100
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B7623331D
	for <lists+linux-sctp@lfdr.de>; Mon, 09 Mar 2026 03:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7864330125D2
	for <lists+linux-sctp@lfdr.de>; Mon,  9 Mar 2026 02:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37D423D2A3;
	Mon,  9 Mar 2026 02:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ivRXx5Oj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OnowB2R8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ivRXx5Oj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OnowB2R8"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0AA23183B
	for <linux-sctp@vger.kernel.org>; Mon,  9 Mar 2026 02:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773022868; cv=none; b=VAZnKxh+uwoYmItJl3i8U+GeW8rAqIdC7+slXe2ctiQdqWXSyNtPCHQ+Rj/0styOBvAS1joN/NrJT17Ze+XhSZsDGVfEj+iCIroEi3Uh7DG4wEdfD9d2JB29Q85hvGCsW7UGYKSv38w3xenHdJs3btuBLgfvVATfBfRwU4G3xQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773022868; c=relaxed/simple;
	bh=9oIdB65xkGcnD4QVv8aacj2gF35ruEaQ9bltldsurWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jeoWeGLANvV/6R0vEzqE+GhQoj+hB6zg5cRVO64amJZI/EbYluQ/31W9yQgz83xxe6Tqbe5hXvGulsvuf9kpjDcsKBWRzP1f3lAZBSL6auahxB34R2RGgW8gLakcbEv0InbLlLY9yyjp1qlfyjaHP20bXy2q/jKQz8NjecVbQM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ivRXx5Oj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OnowB2R8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ivRXx5Oj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OnowB2R8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0F4565BDDE;
	Mon,  9 Mar 2026 02:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773022864; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WjG4ib8vehXL8WZreb8zwLoBFdV2J5UTXxhsLl3FAVw=;
	b=ivRXx5OjHjBhcIOjREvA/2OrtGkdTQbz1UDNAJbSvXh7ulfez2Hb82vFjScOUa5DPf9L0u
	DQok4O6qu0aoevUtzGhii/9prdCsb19SgZu32zt2NN8MiVPtuMpIQxV9DC2+gI1e0/sqhD
	VCa/mBTResjT0yWsCJ7MVaelmz84OWI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773022864;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WjG4ib8vehXL8WZreb8zwLoBFdV2J5UTXxhsLl3FAVw=;
	b=OnowB2R8Zm4rOKQqLNdQGg9rjDb2PZLQtcDIhV1SkzFa5IkESmqO9Y8lfE41C1JYfb2ZnS
	i3JkLxnzl3r8O0Dw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773022864; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WjG4ib8vehXL8WZreb8zwLoBFdV2J5UTXxhsLl3FAVw=;
	b=ivRXx5OjHjBhcIOjREvA/2OrtGkdTQbz1UDNAJbSvXh7ulfez2Hb82vFjScOUa5DPf9L0u
	DQok4O6qu0aoevUtzGhii/9prdCsb19SgZu32zt2NN8MiVPtuMpIQxV9DC2+gI1e0/sqhD
	VCa/mBTResjT0yWsCJ7MVaelmz84OWI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773022864;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WjG4ib8vehXL8WZreb8zwLoBFdV2J5UTXxhsLl3FAVw=;
	b=OnowB2R8Zm4rOKQqLNdQGg9rjDb2PZLQtcDIhV1SkzFa5IkESmqO9Y8lfE41C1JYfb2ZnS
	i3JkLxnzl3r8O0Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE9CF3EC6F;
	Mon,  9 Mar 2026 02:20:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iHfhMosurmk0MgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 09 Mar 2026 02:20:59 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Saurav Kashyap <skashyap@marvell.com>,
	Javed Hasan <jhasan@marvell.com>,
	GR-QLogic-Storage-Upstream@marvell.com (maintainer:BROADCOM BNX2FC 10 GIGABIT FCOE DRIVER),
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Nilesh Javali <njavali@marvell.com>,
	Manish Rangankar <mrangankar@marvell.com>,
	Varun Prakash <varun@chelsio.com>,
	Alexander Aring <aahringo@redhat.com>,
	David Teigland <teigland@redhat.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	David Ahern <dsahern@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	Jon Maloy <jmaloy@redhat.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Luca Weiss <luca.weiss@fairphone.com>,
	Sven Peter <sven@kernel.org>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Gow <david@davidgow.net>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Ryota Sakamoto <sakamo.ryota@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Kir Chou <note351@hotmail.com>,
	Kuan-Wei Chiu <visitorckw@gmail.com>,
	Vikas Gupta <vikas.gupta@broadcom.com>,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>,
	=?UTF-8?q?Markus=20Bl=C3=B6chl?= <markus@blochl.de>,
	linux-m68k@lists.linux-m68k.org (open list:M68K ARCHITECTURE),
	linux-rdma@vger.kernel.org (open list:INFINIBAND SUBSYSTEM),
	oss-drivers@corigine.com (open list:NETRONOME ETHERNET DRIVERS),
	linux-scsi@vger.kernel.org (open list:BROADCOM BNX2FC 10 GIGABIT FCOE DRIVER),
	gfs2@lists.linux.dev (open list:DISTRIBUTED LOCK MANAGER (DLM)),
	bridge@lists.linux.dev (open list:ETHERNET BRIDGE),
	netfilter-devel@vger.kernel.org (open list:NETFILTER),
	coreteam@netfilter.org (open list:NETFILTER),
	linux-afs@lists.infradead.org (open list:RXRPC SOCKETS (AF_RXRPC)),
	linux-sctp@vger.kernel.org (open list:SCTP PROTOCOL),
	tipc-discussion@lists.sourceforge.net (open list:TIPC NETWORK LAYER)
Subject: [PATCH 01/10 net-next] ipv6: convert CONFIG_IPV6 to built-in only and clean up Kconfigs
Date: Mon,  9 Mar 2026 03:19:34 +0100
Message-ID: <20260309022013.5199-2-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260309022013.5199-1-fmancera@suse.de>
References: <20260309022013.5199-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: 0.70
X-Spam-Level: 
X-Rspamd-Queue-Id: 27B7623331D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-978-lists,linux-sctp=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,suse.de,linux-m68k.org,ziepe.ca,kernel.org,broadcom.com,lunn.ch,davemloft.net,google.com,redhat.com,nvidia.com,marvell.com,HansenPartnership.com,oracle.com,chelsio.com,blackwall.org,netfilter.org,strlen.de,nwl.cc,auristor.com,gmail.com,oss.qualcomm.com,arndb.de,amd.com,fairphone.com,bp.renesas.com,renesas.com,linux-foundation.org,davidgow.net,gondor.apana.org.au,hotmail.com,blochl.de,lists.linux-m68k.org,corigine.com,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,linux-sctp@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[62];
	TAGGED_RCPT(0.00)[linux-sctp,netdev];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Configuring IPV6 as a module provides little or no benefit and requires
time and resources to maintain. Therefore, drop the support for it.

Change CONFIG_IPV6 from tristate to bool. Remove all Kconfig
dependencies across the tree that explicitly checked for IPV6=m. Adjust
all the default configurations from CONFIG_IPV6=m to CONFIG_IPV6=y. In
addition, remove MODULE_DESCRIPTION(), MODULE_ALIAS(), MODULE_AUTHOR()
and MODULE_LICENSE().

This is also replacing module_init() by fs_initcall().

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 arch/arm64/configs/defconfig                | 2 +-
 arch/m68k/configs/amiga_defconfig           | 2 +-
 arch/m68k/configs/apollo_defconfig          | 2 +-
 arch/m68k/configs/atari_defconfig           | 2 +-
 arch/m68k/configs/bvme6000_defconfig        | 2 +-
 arch/m68k/configs/hp300_defconfig           | 2 +-
 arch/m68k/configs/mac_defconfig             | 2 +-
 arch/m68k/configs/multi_defconfig           | 2 +-
 arch/m68k/configs/mvme147_defconfig         | 2 +-
 arch/m68k/configs/mvme16x_defconfig         | 2 +-
 arch/m68k/configs/q40_defconfig             | 2 +-
 arch/m68k/configs/sun3_defconfig            | 2 +-
 arch/m68k/configs/sun3x_defconfig           | 2 +-
 drivers/infiniband/Kconfig                  | 1 -
 drivers/infiniband/hw/ocrdma/Kconfig        | 2 +-
 drivers/infiniband/ulp/ipoib/Kconfig        | 2 +-
 drivers/net/Kconfig                         | 9 ---------
 drivers/net/ethernet/broadcom/Kconfig       | 2 +-
 drivers/net/ethernet/chelsio/Kconfig        | 2 +-
 drivers/net/ethernet/mellanox/mlxsw/Kconfig | 1 -
 drivers/net/ethernet/netronome/Kconfig      | 1 -
 drivers/scsi/bnx2fc/Kconfig                 | 1 -
 drivers/scsi/bnx2i/Kconfig                  | 1 -
 drivers/scsi/cxgbi/cxgb3i/Kconfig           | 2 +-
 drivers/scsi/cxgbi/cxgb4i/Kconfig           | 2 +-
 fs/dlm/Kconfig                              | 2 +-
 fs/gfs2/Kconfig                             | 2 +-
 net/bridge/Kconfig                          | 1 -
 net/ipv4/Kconfig                            | 9 ++++-----
 net/ipv6/Kconfig                            | 6 +-----
 net/ipv6/af_inet6.c                         | 8 +-------
 net/l2tp/Kconfig                            | 1 -
 net/netfilter/Kconfig                       | 8 --------
 net/rxrpc/Kconfig                           | 2 +-
 net/sctp/Kconfig                            | 1 -
 net/tipc/Kconfig                            | 1 -
 36 files changed, 28 insertions(+), 65 deletions(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index b67d5b1fc45b..0651a771f5c1 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -140,7 +140,7 @@ CONFIG_IP_MULTICAST=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
-CONFIG_IPV6=m
+CONFIG_IPV6=y
 CONFIG_NETFILTER=y
 CONFIG_BRIDGE_NETFILTER=m
 CONFIG_NF_CONNTRACK=m
diff --git a/arch/m68k/configs/amiga_defconfig b/arch/m68k/configs/amiga_defconfig
index 31d16cba9879..ba511da41ec8 100644
--- a/arch/m68k/configs/amiga_defconfig
+++ b/arch/m68k/configs/amiga_defconfig
@@ -72,7 +72,7 @@ CONFIG_INET_IPCOMP=m
 CONFIG_INET_DIAG=m
 CONFIG_INET_UDP_DIAG=m
 CONFIG_INET_RAW_DIAG=m
-CONFIG_IPV6=m
+CONFIG_IPV6=y
 CONFIG_IPV6_ROUTER_PREF=y
 CONFIG_INET6_AH=m
 CONFIG_INET6_ESP=m
diff --git a/arch/m68k/configs/apollo_defconfig b/arch/m68k/configs/apollo_defconfig
index c0c419ec9a9e..0a5f045c5a86 100644
--- a/arch/m68k/configs/apollo_defconfig
+++ b/arch/m68k/configs/apollo_defconfig
@@ -68,7 +68,7 @@ CONFIG_INET_IPCOMP=m
 CONFIG_INET_DIAG=m
 CONFIG_INET_UDP_DIAG=m
 CONFIG_INET_RAW_DIAG=m
-CONFIG_IPV6=m
+CONFIG_IPV6=y
 CONFIG_IPV6_ROUTER_PREF=y
 CONFIG_INET6_AH=m
 CONFIG_INET6_ESP=m
diff --git a/arch/m68k/configs/atari_defconfig b/arch/m68k/configs/atari_defconfig
index 2b7547ecc4c4..d1506feb27f5 100644
--- a/arch/m68k/configs/atari_defconfig
+++ b/arch/m68k/configs/atari_defconfig
@@ -75,7 +75,7 @@ CONFIG_INET_IPCOMP=m
 CONFIG_INET_DIAG=m
 CONFIG_INET_UDP_DIAG=m
 CONFIG_INET_RAW_DIAG=m
-CONFIG_IPV6=m
+CONFIG_IPV6=y
 CONFIG_IPV6_ROUTER_PREF=y
 CONFIG_INET6_AH=m
 CONFIG_INET6_ESP=m
diff --git a/arch/m68k/configs/bvme6000_defconfig b/arch/m68k/configs/bvme6000_defconfig
index 0b63787cff0d..4614d383fe9b 100644
--- a/arch/m68k/configs/bvme6000_defconfig
+++ b/arch/m68k/configs/bvme6000_defconfig
@@ -65,7 +65,7 @@ CONFIG_INET_IPCOMP=m
 CONFIG_INET_DIAG=m
 CONFIG_INET_UDP_DIAG=m
 CONFIG_INET_RAW_DIAG=m
-CONFIG_IPV6=m
+CONFIG_IPV6=y
 CONFIG_IPV6_ROUTER_PREF=y
 CONFIG_INET6_AH=m
 CONFIG_INET6_ESP=m
diff --git a/arch/m68k/configs/hp300_defconfig b/arch/m68k/configs/hp300_defconfig
index 308836b60bba..d0e74a2f01e3 100644
--- a/arch/m68k/configs/hp300_defconfig
+++ b/arch/m68k/configs/hp300_defconfig
@@ -67,7 +67,7 @@ CONFIG_INET_IPCOMP=m
 CONFIG_INET_DIAG=m
 CONFIG_INET_UDP_DIAG=m
 CONFIG_INET_RAW_DIAG=m
-CONFIG_IPV6=m
+CONFIG_IPV6=y
 CONFIG_IPV6_ROUTER_PREF=y
 CONFIG_INET6_AH=m
 CONFIG_INET6_ESP=m
diff --git a/arch/m68k/configs/mac_defconfig b/arch/m68k/configs/mac_defconfig
index 97e108c0d24f..aa5b8682503a 100644
--- a/arch/m68k/configs/mac_defconfig
+++ b/arch/m68k/configs/mac_defconfig
@@ -66,7 +66,7 @@ CONFIG_INET_IPCOMP=m
 CONFIG_INET_DIAG=m
 CONFIG_INET_UDP_DIAG=m
 CONFIG_INET_RAW_DIAG=m
-CONFIG_IPV6=m
+CONFIG_IPV6=y
 CONFIG_IPV6_ROUTER_PREF=y
 CONFIG_INET6_AH=m
 CONFIG_INET6_ESP=m
diff --git a/arch/m68k/configs/multi_defconfig b/arch/m68k/configs/multi_defconfig
index 7e9f83af9af4..99e0bc09cb41 100644
--- a/arch/m68k/configs/multi_defconfig
+++ b/arch/m68k/configs/multi_defconfig
@@ -86,7 +86,7 @@ CONFIG_INET_IPCOMP=m
 CONFIG_INET_DIAG=m
 CONFIG_INET_UDP_DIAG=m
 CONFIG_INET_RAW_DIAG=m
-CONFIG_IPV6=m
+CONFIG_IPV6=y
 CONFIG_IPV6_ROUTER_PREF=y
 CONFIG_INET6_AH=m
 CONFIG_INET6_ESP=m
diff --git a/arch/m68k/configs/mvme147_defconfig b/arch/m68k/configs/mvme147_defconfig
index 2fe33271d249..f36844c03074 100644
--- a/arch/m68k/configs/mvme147_defconfig
+++ b/arch/m68k/configs/mvme147_defconfig
@@ -64,7 +64,7 @@ CONFIG_INET_IPCOMP=m
 CONFIG_INET_DIAG=m
 CONFIG_INET_UDP_DIAG=m
 CONFIG_INET_RAW_DIAG=m
-CONFIG_IPV6=m
+CONFIG_IPV6=y
 CONFIG_IPV6_ROUTER_PREF=y
 CONFIG_INET6_AH=m
 CONFIG_INET6_ESP=m
diff --git a/arch/m68k/configs/mvme16x_defconfig b/arch/m68k/configs/mvme16x_defconfig
index 4308daaa7f74..be89e951e8bc 100644
--- a/arch/m68k/configs/mvme16x_defconfig
+++ b/arch/m68k/configs/mvme16x_defconfig
@@ -65,7 +65,7 @@ CONFIG_INET_IPCOMP=m
 CONFIG_INET_DIAG=m
 CONFIG_INET_UDP_DIAG=m
 CONFIG_INET_RAW_DIAG=m
-CONFIG_IPV6=m
+CONFIG_IPV6=y
 CONFIG_IPV6_ROUTER_PREF=y
 CONFIG_INET6_AH=m
 CONFIG_INET6_ESP=m
diff --git a/arch/m68k/configs/q40_defconfig b/arch/m68k/configs/q40_defconfig
index 36eb29ec54ee..0c1b17d12204 100644
--- a/arch/m68k/configs/q40_defconfig
+++ b/arch/m68k/configs/q40_defconfig
@@ -66,7 +66,7 @@ CONFIG_INET_IPCOMP=m
 CONFIG_INET_DIAG=m
 CONFIG_INET_UDP_DIAG=m
 CONFIG_INET_RAW_DIAG=m
-CONFIG_IPV6=m
+CONFIG_IPV6=y
 CONFIG_IPV6_ROUTER_PREF=y
 CONFIG_INET6_AH=m
 CONFIG_INET6_ESP=m
diff --git a/arch/m68k/configs/sun3_defconfig b/arch/m68k/configs/sun3_defconfig
index 524a89fa6953..a39df48a3f19 100644
--- a/arch/m68k/configs/sun3_defconfig
+++ b/arch/m68k/configs/sun3_defconfig
@@ -61,7 +61,7 @@ CONFIG_INET_IPCOMP=m
 CONFIG_INET_DIAG=m
 CONFIG_INET_UDP_DIAG=m
 CONFIG_INET_RAW_DIAG=m
-CONFIG_IPV6=m
+CONFIG_IPV6=y
 CONFIG_IPV6_ROUTER_PREF=y
 CONFIG_INET6_AH=m
 CONFIG_INET6_ESP=m
diff --git a/arch/m68k/configs/sun3x_defconfig b/arch/m68k/configs/sun3x_defconfig
index f4fbc65c52d9..921f2c138b48 100644
--- a/arch/m68k/configs/sun3x_defconfig
+++ b/arch/m68k/configs/sun3x_defconfig
@@ -62,7 +62,7 @@ CONFIG_INET_IPCOMP=m
 CONFIG_INET_DIAG=m
 CONFIG_INET_UDP_DIAG=m
 CONFIG_INET_RAW_DIAG=m
-CONFIG_IPV6=m
+CONFIG_IPV6=y
 CONFIG_IPV6_ROUTER_PREF=y
 CONFIG_INET6_AH=m
 CONFIG_INET6_ESP=m
diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
index 78ac2ff5befd..23f4245f7d7d 100644
--- a/drivers/infiniband/Kconfig
+++ b/drivers/infiniband/Kconfig
@@ -4,7 +4,6 @@ menuconfig INFINIBAND
 	depends on HAS_IOMEM && HAS_DMA
 	depends on NET
 	depends on INET
-	depends on m || IPV6 != m
 	depends on !ALPHA
 	select DMA_SHARED_BUFFER
 	select IRQ_POLL
diff --git a/drivers/infiniband/hw/ocrdma/Kconfig b/drivers/infiniband/hw/ocrdma/Kconfig
index 54bd70bc4d1a..b50c5f507e7c 100644
--- a/drivers/infiniband/hw/ocrdma/Kconfig
+++ b/drivers/infiniband/hw/ocrdma/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config INFINIBAND_OCRDMA
 	tristate "Emulex One Connect HCA support"
-	depends on ETHERNET && NETDEVICES && PCI && INET && (IPV6 || IPV6=n)
+	depends on ETHERNET && NETDEVICES && PCI && INET
 	select NET_VENDOR_EMULEX
 	select BE2NET
 	help
diff --git a/drivers/infiniband/ulp/ipoib/Kconfig b/drivers/infiniband/ulp/ipoib/Kconfig
index 254e31a90a66..b5253a231bdd 100644
--- a/drivers/infiniband/ulp/ipoib/Kconfig
+++ b/drivers/infiniband/ulp/ipoib/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config INFINIBAND_IPOIB
 	tristate "IP-over-InfiniBand"
-	depends on NETDEVICES && INET && (IPV6 || IPV6=n)
+	depends on NETDEVICES && INET
 	help
 	  Support for the IP-over-InfiniBand protocol (IPoIB). This
 	  transports IP packets over InfiniBand so you can use your IB
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 17108c359216..46f37ec713b8 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -41,7 +41,6 @@ if NET_CORE
 config BONDING
 	tristate "Bonding driver support"
 	depends on INET
-	depends on IPV6 || IPV6=n
 	depends on TLS || TLS_DEVICE=n
 	help
 	  Say 'Y' or 'M' if you wish to be able to 'bond' multiple Ethernet
@@ -75,7 +74,6 @@ config DUMMY
 config WIREGUARD
 	tristate "WireGuard secure network tunnel"
 	depends on NET && INET
-	depends on IPV6 || !IPV6
 	select NET_UDP_TUNNEL
 	select DST_CACHE
 	select CRYPTO_LIB_CURVE25519
@@ -105,7 +103,6 @@ config WIREGUARD_DEBUG
 config OVPN
 	tristate "OpenVPN data channel offload"
 	depends on NET && INET
-	depends on IPV6 || !IPV6
 	select DST_CACHE
 	select NET_UDP_TUNNEL
 	select CRYPTO
@@ -202,7 +199,6 @@ config IPVLAN_L3S
 config IPVLAN
 	tristate "IP-VLAN support"
 	depends on INET
-	depends on IPV6 || !IPV6
 	help
 	  This allows one to create virtual devices off of a main interface
 	  and packets will be delivered based on the dest L3 (IPv6/IPv4 addr)
@@ -249,7 +245,6 @@ config VXLAN
 config GENEVE
 	tristate "Generic Network Virtualization Encapsulation"
 	depends on INET
-	depends on IPV6 || !IPV6
 	select NET_UDP_TUNNEL
 	select GRO_CELLS
 	help
@@ -265,7 +260,6 @@ config GENEVE
 config BAREUDP
 	tristate "Bare UDP Encapsulation"
 	depends on INET
-	depends on IPV6 || !IPV6
 	select NET_UDP_TUNNEL
 	select GRO_CELLS
 	help
@@ -308,7 +302,6 @@ config PFCP
 config AMT
 	tristate "Automatic Multicast Tunneling (AMT)"
 	depends on INET && IP_MULTICAST
-	depends on IPV6 || !IPV6
 	select NET_UDP_TUNNEL
 	help
 	  This allows one to create AMT(Automatic Multicast Tunneling)
@@ -479,7 +472,6 @@ config NET_VRF
 	tristate "Virtual Routing and Forwarding (Lite)"
 	depends on IP_MULTIPLE_TABLES
 	depends on NET_L3_MASTER_DEV
-	depends on IPV6 || IPV6=n
 	depends on IPV6_MULTIPLE_TABLES || IPV6=n
 	help
 	  This option enables the support for mapping interfaces into VRF's. The
@@ -614,7 +606,6 @@ config NETDEVSIM
 	tristate "Simulated networking device"
 	depends on DEBUG_FS
 	depends on INET
-	depends on IPV6 || IPV6=n
 	depends on PSAMPLE || PSAMPLE=n
 	depends on PTP_1588_CLOCK_MOCK || PTP_1588_CLOCK_MOCK=n
 	select NET_DEVLINK
diff --git a/drivers/net/ethernet/broadcom/Kconfig b/drivers/net/ethernet/broadcom/Kconfig
index cd7dddeb91dd..3190231c91da 100644
--- a/drivers/net/ethernet/broadcom/Kconfig
+++ b/drivers/net/ethernet/broadcom/Kconfig
@@ -96,7 +96,7 @@ config BNX2
 
 config CNIC
 	tristate "QLogic CNIC support"
-	depends on PCI && (IPV6 || IPV6=n)
+	depends on PCI
 	select BNX2
 	select UIO
 	help
diff --git a/drivers/net/ethernet/chelsio/Kconfig b/drivers/net/ethernet/chelsio/Kconfig
index c931ec8cac40..96d7779cd2f0 100644
--- a/drivers/net/ethernet/chelsio/Kconfig
+++ b/drivers/net/ethernet/chelsio/Kconfig
@@ -68,7 +68,7 @@ config CHELSIO_T3
 
 config CHELSIO_T4
 	tristate "Chelsio Communications T4/T5/T6 Ethernet support"
-	depends on PCI && (IPV6 || IPV6=n) && (TLS || TLS=n)
+	depends on PCI && (TLS || TLS=n)
 	depends on PTP_1588_CLOCK_OPTIONAL
 	select FW_LOADER
 	select MDIO
diff --git a/drivers/net/ethernet/mellanox/mlxsw/Kconfig b/drivers/net/ethernet/mellanox/mlxsw/Kconfig
index 74f7e27b490f..2229a2694aa5 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/Kconfig
+++ b/drivers/net/ethernet/mellanox/mlxsw/Kconfig
@@ -56,7 +56,6 @@ config MLXSW_SPECTRUM
 	depends on MLXSW_CORE && MLXSW_PCI && NET_SWITCHDEV && VLAN_8021Q
 	depends on PSAMPLE || PSAMPLE=n
 	depends on BRIDGE || BRIDGE=n
-	depends on IPV6 || IPV6=n
 	depends on NET_IPGRE || NET_IPGRE=n
 	depends on IPV6_GRE || IPV6_GRE=n
 	depends on VXLAN || VXLAN=n
diff --git a/drivers/net/ethernet/netronome/Kconfig b/drivers/net/ethernet/netronome/Kconfig
index d03d6e96f730..d115d16d4649 100644
--- a/drivers/net/ethernet/netronome/Kconfig
+++ b/drivers/net/ethernet/netronome/Kconfig
@@ -33,7 +33,6 @@ config NFP_APP_FLOWER
 	bool "NFP4000/NFP6000 TC Flower offload support"
 	depends on NFP
 	depends on NET_SWITCHDEV
-	depends on IPV6!=m || NFP=m
 	default y
 	help
 	  Enable driver support for TC Flower offload on NFP4000 and NFP6000.
diff --git a/drivers/scsi/bnx2fc/Kconfig b/drivers/scsi/bnx2fc/Kconfig
index 3cf7e08df809..d12eeb13384a 100644
--- a/drivers/scsi/bnx2fc/Kconfig
+++ b/drivers/scsi/bnx2fc/Kconfig
@@ -2,7 +2,6 @@
 config SCSI_BNX2X_FCOE
 	tristate "QLogic FCoE offload support"
 	depends on PCI
-	depends on (IPV6 || IPV6=n)
 	depends on LIBFC
 	depends on LIBFCOE
 	select NETDEVICES
diff --git a/drivers/scsi/bnx2i/Kconfig b/drivers/scsi/bnx2i/Kconfig
index 75ace2302fed..e649a04fab1d 100644
--- a/drivers/scsi/bnx2i/Kconfig
+++ b/drivers/scsi/bnx2i/Kconfig
@@ -3,7 +3,6 @@ config SCSI_BNX2_ISCSI
 	tristate "QLogic NetXtreme II iSCSI support"
 	depends on NET
 	depends on PCI
-	depends on (IPV6 || IPV6=n)
 	select SCSI_ISCSI_ATTRS
 	select NETDEVICES
 	select ETHERNET
diff --git a/drivers/scsi/cxgbi/cxgb3i/Kconfig b/drivers/scsi/cxgbi/cxgb3i/Kconfig
index e20e6f3bfe64..143e881ec77e 100644
--- a/drivers/scsi/cxgbi/cxgb3i/Kconfig
+++ b/drivers/scsi/cxgbi/cxgb3i/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config SCSI_CXGB3_ISCSI
 	tristate "Chelsio T3 iSCSI support"
-	depends on PCI && INET && (IPV6 || IPV6=n)
+	depends on PCI && INET
 	select NETDEVICES
 	select ETHERNET
 	select NET_VENDOR_CHELSIO
diff --git a/drivers/scsi/cxgbi/cxgb4i/Kconfig b/drivers/scsi/cxgbi/cxgb4i/Kconfig
index 63c8a0f3cd0c..dd1c8ff36b00 100644
--- a/drivers/scsi/cxgbi/cxgb4i/Kconfig
+++ b/drivers/scsi/cxgbi/cxgb4i/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config SCSI_CXGB4_ISCSI
 	tristate "Chelsio T4 iSCSI support"
-	depends on PCI && INET && (IPV6 || IPV6=n)
+	depends on PCI && INET
 	depends on PTP_1588_CLOCK_OPTIONAL
 	depends on THERMAL || !THERMAL
 	depends on ETHERNET
diff --git a/fs/dlm/Kconfig b/fs/dlm/Kconfig
index b46165df5a91..fb6ba9f5a634 100644
--- a/fs/dlm/Kconfig
+++ b/fs/dlm/Kconfig
@@ -2,7 +2,7 @@
 menuconfig DLM
 	tristate "Distributed Lock Manager (DLM)"
 	depends on INET
-	depends on SYSFS && CONFIGFS_FS && (IPV6 || IPV6=n)
+	depends on SYSFS && CONFIGFS_FS
 	help
 	A general purpose distributed lock manager for kernel or userspace
 	applications.
diff --git a/fs/gfs2/Kconfig b/fs/gfs2/Kconfig
index 7bd231d16d4a..8beee571b6af 100644
--- a/fs/gfs2/Kconfig
+++ b/fs/gfs2/Kconfig
@@ -26,7 +26,7 @@ config GFS2_FS
 
 config GFS2_FS_LOCKING_DLM
 	bool "GFS2 DLM locking"
-	depends on (GFS2_FS!=n) && NET && INET && (IPV6 || IPV6=n) && \
+	depends on (GFS2_FS!=n) && NET && INET && \
 		CONFIGFS_FS && SYSFS && (DLM=y || DLM=GFS2_FS)
 	help
 	  Multiple node locking module for GFS2
diff --git a/net/bridge/Kconfig b/net/bridge/Kconfig
index 3c8ded7d3e84..318715c8fc9b 100644
--- a/net/bridge/Kconfig
+++ b/net/bridge/Kconfig
@@ -7,7 +7,6 @@ config BRIDGE
 	tristate "802.1d Ethernet Bridging"
 	select LLC
 	select STP
-	depends on IPV6 || IPV6=n
 	help
 	  If you say Y here, then your Linux box will be able to act as an
 	  Ethernet bridge, which means that the different Ethernet segments it
diff --git a/net/ipv4/Kconfig b/net/ipv4/Kconfig
index df922f9f5289..21e5164e30db 100644
--- a/net/ipv4/Kconfig
+++ b/net/ipv4/Kconfig
@@ -191,7 +191,7 @@ config NET_IP_TUNNEL
 
 config NET_IPGRE
 	tristate "IP: GRE tunnels over IP"
-	depends on (IPV6 || IPV6=n) && NET_IPGRE_DEMUX
+	depends on NET_IPGRE_DEMUX
 	select NET_IP_TUNNEL
 	help
 	  Tunneling means encapsulating data of one protocol type within
@@ -303,7 +303,6 @@ config SYN_COOKIES
 
 config NET_IPVTI
 	tristate "Virtual (secure) IP: tunneling"
-	depends on IPV6 || IPV6=n
 	select INET_TUNNEL
 	select NET_IP_TUNNEL
 	select XFRM
@@ -439,7 +438,7 @@ config INET_TCP_DIAG
 
 config INET_UDP_DIAG
 	tristate "UDP: socket monitoring interface"
-	depends on INET_DIAG && (IPV6 || IPV6=n)
+	depends on INET_DIAG
 	default n
 	help
 	  Support for UDP socket monitoring interface used by the ss tool.
@@ -447,7 +446,7 @@ config INET_UDP_DIAG
 
 config INET_RAW_DIAG
 	tristate "RAW: socket monitoring interface"
-	depends on INET_DIAG && (IPV6 || IPV6=n)
+	depends on INET_DIAG
 	default n
 	help
 	  Support for RAW socket monitoring interface used by the ss tool.
@@ -750,7 +749,7 @@ config TCP_AO
 	select CRYPTO
 	select CRYPTO_LIB_UTILS
 	select TCP_SIGPOOL
-	depends on 64BIT && IPV6 != m # seq-number extension needs WRITE_ONCE(u64)
+	depends on 64BIT # seq-number extension needs WRITE_ONCE(u64)
 	help
 	  TCP-AO specifies the use of stronger Message Authentication Codes (MACs),
 	  protects against replays for long-lived TCP connections, and
diff --git a/net/ipv6/Kconfig b/net/ipv6/Kconfig
index b8f9a8c0302e..c024aa77f25b 100644
--- a/net/ipv6/Kconfig
+++ b/net/ipv6/Kconfig
@@ -3,9 +3,8 @@
 # IPv6 configuration
 #
 
-#   IPv6 as module will cause a CRASH if you try to unload it
 menuconfig IPV6
-	tristate "The IPv6 protocol"
+	bool "The IPv6 protocol"
 	default y
 	select CRYPTO_LIB_SHA1
 	help
@@ -17,9 +16,6 @@ menuconfig IPV6
 	  Documentation/networking/ipv6.rst and read the HOWTO at
 	  <https://www.tldp.org/HOWTO/Linux+IPv6-HOWTO/>
 
-	  To compile this protocol support as a module, choose M here: the
-	  module will be called ipv6.
-
 if IPV6
 
 config IPV6_ROUTER_PREF
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 0b995a961359..cfdac4753683 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -71,10 +71,6 @@
 
 #include "ip6_offload.h"
 
-MODULE_AUTHOR("Cast of dozens");
-MODULE_DESCRIPTION("IPv6 protocol stack for Linux");
-MODULE_LICENSE("GPL");
-
 /* The inetsw6 table contains everything that inet6_create needs to
  * build a new socket.
  */
@@ -1312,6 +1308,4 @@ static int __init inet6_init(void)
 	proto_unregister(&tcpv6_prot);
 	goto out;
 }
-module_init(inet6_init);
-
-MODULE_ALIAS_NETPROTO(PF_INET6);
+fs_initcall(inet6_init);
diff --git a/net/l2tp/Kconfig b/net/l2tp/Kconfig
index b7856748e960..0de178d5baba 100644
--- a/net/l2tp/Kconfig
+++ b/net/l2tp/Kconfig
@@ -5,7 +5,6 @@
 
 menuconfig L2TP
 	tristate "Layer Two Tunneling Protocol (L2TP)"
-	depends on (IPV6 || IPV6=n)
 	depends on INET
 	select NET_UDP_TUNNEL
 	help
diff --git a/net/netfilter/Kconfig b/net/netfilter/Kconfig
index 6cdc994fdc8a..f3ea0cb26f36 100644
--- a/net/netfilter/Kconfig
+++ b/net/netfilter/Kconfig
@@ -249,7 +249,6 @@ config NF_CONNTRACK_FTP
 
 config NF_CONNTRACK_H323
 	tristate "H.323 protocol support"
-	depends on IPV6 || IPV6=n
 	depends on NETFILTER_ADVANCED
 	help
 	  H.323 is a VoIP signalling protocol from ITU-T. As one of the most
@@ -589,7 +588,6 @@ config NFT_QUOTA
 config NFT_REJECT
 	default m if NETFILTER_ADVANCED=n
 	tristate "Netfilter nf_tables reject support"
-	depends on !NF_TABLES_INET || (IPV6!=m || m)
 	help
 	  This option adds the "reject" expression that you can use to
 	  explicitly deny and notify via TCP reset/ICMP informational errors
@@ -636,7 +634,6 @@ config NFT_XFRM
 
 config NFT_SOCKET
 	tristate "Netfilter nf_tables socket match support"
-	depends on IPV6 || IPV6=n
 	select NF_SOCKET_IPV4
 	select NF_SOCKET_IPV6 if NF_TABLES_IPV6
 	help
@@ -652,7 +649,6 @@ config NFT_OSF
 
 config NFT_TPROXY
 	tristate "Netfilter nf_tables tproxy support"
-	depends on IPV6 || IPV6=n
 	select NF_DEFRAG_IPV4
 	select NF_DEFRAG_IPV6 if NF_TABLES_IPV6
 	select NF_TPROXY_IPV4
@@ -1071,7 +1067,6 @@ config NETFILTER_XT_TARGET_MASQUERADE
 config NETFILTER_XT_TARGET_TEE
 	tristate '"TEE" - packet cloning to alternate destination'
 	depends on NETFILTER_ADVANCED
-	depends on IPV6 || IPV6=n
 	depends on !NF_CONNTRACK || NF_CONNTRACK
 	depends on IP6_NF_IPTABLES || !IP6_NF_IPTABLES
 	select NF_DUP_IPV4
@@ -1084,7 +1079,6 @@ config NETFILTER_XT_TARGET_TPROXY
 	tristate '"TPROXY" target transparent proxying support'
 	depends on NETFILTER_XTABLES
 	depends on NETFILTER_ADVANCED
-	depends on IPV6 || IPV6=n
 	depends on IP6_NF_IPTABLES || IP6_NF_IPTABLES=n
 	depends on IP_NF_MANGLE || NFT_COMPAT
 	select NF_DEFRAG_IPV4
@@ -1126,7 +1120,6 @@ config NETFILTER_XT_TARGET_SECMARK
 
 config NETFILTER_XT_TARGET_TCPMSS
 	tristate '"TCPMSS" target support'
-	depends on IPV6 || IPV6=n
 	default m if NETFILTER_ADVANCED=n
 	help
 	  This option adds a `TCPMSS' target, which allows you to alter the
@@ -1581,7 +1574,6 @@ config NETFILTER_XT_MATCH_SOCKET
 	tristate '"socket" match support'
 	depends on NETFILTER_XTABLES
 	depends on NETFILTER_ADVANCED
-	depends on IPV6 || IPV6=n
 	depends on IP6_NF_IPTABLES || IP6_NF_IPTABLES=n
 	select NF_SOCKET_IPV4
 	select NF_SOCKET_IPV6 if IP6_NF_IPTABLES
diff --git a/net/rxrpc/Kconfig b/net/rxrpc/Kconfig
index f60b81c66078..43416b3026fb 100644
--- a/net/rxrpc/Kconfig
+++ b/net/rxrpc/Kconfig
@@ -25,7 +25,7 @@ if AF_RXRPC
 
 config AF_RXRPC_IPV6
 	bool "IPv6 support for RxRPC"
-	depends on (IPV6 = m && AF_RXRPC = m) || (IPV6 = y && AF_RXRPC)
+	depends on IPV6
 	help
 	  Say Y here to allow AF_RXRPC to use IPV6 UDP as well as IPV4 UDP as
 	  its network transport.
diff --git a/net/sctp/Kconfig b/net/sctp/Kconfig
index e947646a380c..fc989a3791b3 100644
--- a/net/sctp/Kconfig
+++ b/net/sctp/Kconfig
@@ -6,7 +6,6 @@
 menuconfig IP_SCTP
 	tristate "The SCTP Protocol"
 	depends on INET
-	depends on IPV6 || IPV6=n
 	select CRYPTO_LIB_SHA1
 	select CRYPTO_LIB_SHA256
 	select CRYPTO_LIB_UTILS
diff --git a/net/tipc/Kconfig b/net/tipc/Kconfig
index bb0d71eb02a6..18f62135e47b 100644
--- a/net/tipc/Kconfig
+++ b/net/tipc/Kconfig
@@ -6,7 +6,6 @@
 menuconfig TIPC
 	tristate "The TIPC Protocol"
 	depends on INET
-	depends on IPV6 || IPV6=n
 	help
 	  The Transparent Inter Process Communication (TIPC) protocol is
 	  specially designed for intra cluster communication. This protocol
-- 
2.53.0


