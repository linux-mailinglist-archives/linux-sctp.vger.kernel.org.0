Return-Path: <linux-sctp+bounces-1326-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4gUxIFJ0U2p/bAMAu9opvQ
	(envelope-from <linux-sctp+bounces-1326-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Sun, 12 Jul 2026 13:02:42 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F05CC744722
	for <lists+linux-sctp@lfdr.de>; Sun, 12 Jul 2026 13:02:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arndb.de header.s=fm1 header.b=zpHRfiC5;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b="l 6PtvRh";
	dmarc=pass (policy=none) header.from=arndb.de;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1326-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1326-lists+linux-sctp=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A46E6300D845
	for <lists+linux-sctp@lfdr.de>; Sun, 12 Jul 2026 11:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48E73A48E3;
	Sun, 12 Jul 2026 11:02:39 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955E7149DF1;
	Sun, 12 Jul 2026 11:02:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783854159; cv=none; b=qfR97Md3x03z4XsjxwSfQOSlgkA4VB4cyZjZv3RaebcL1h61Vtp820wjBGfsXSqogsmBgLoqBF3br6ni9Mf82WBzmNAANviLGhpU9VO2LVmFe6GwF5U4k5otZFglnf6gheTc1IrJ2UpQVcise745g5FKBwz8BVxWQaXg2k1QFnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783854159; c=relaxed/simple;
	bh=QFAERGkwm7FFeWB0LrovUamDAkSprs7aihtdoZvXuKE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=NKoWjzE/U9Cg81q8x/q+xGMA4Dju/BDKtzUlmXLX0P+/vgeMv2dgD7brrPKZqRPslrVfKKuG/wygnWi2EbpqE7SpjguHA8X987epUkETbAPw3BX/AP4rrrvLI7lz9cujWCucBJ4cd0qgsBWNkvrEucHW0ECWq80VWQu4vKXYC3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=zpHRfiC5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l6PtvRhd; arc=none smtp.client-ip=103.168.172.157
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B209314000F9;
	Sun, 12 Jul 2026 07:02:36 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Sun, 12 Jul 2026 07:02:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1783854156;
	 x=1783940556; bh=VmtnK3tqoDU1aIaol+aWaActTb6DTRuQA5S8IlUXC6U=; b=
	zpHRfiC5EPwl520ahCHYKKw5slNvnULR9f0KFrRT9y/2496pQCwk5KRBRbFgaYwK
	qG5F+qyc+u6zQHl69ceJPRiSScFtXeE7ZyRSVgJSuprmdrpegDBkSA7FMJ5iWHIW
	SWlwkvdzIryhehvQjfxl6CaW2ssS7P7s2gf6gPSaRBitFcji6E7w6O+D9MGOTq8e
	KhN1cpA/Tqcli21P3rrlWr0Xxua3FpQ5R7OFYe9FPdjPs6R+VvBCiyDkT0HtPl2f
	qii8ZEdh5SWDrMrxQFPHLV29au4QVk00LL5Ct/0KCqib5HX/6aJG4Up8UlRvgkJY
	nRorXxeir3laErJG81MisA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783854156; x=
	1783940556; bh=VmtnK3tqoDU1aIaol+aWaActTb6DTRuQA5S8IlUXC6U=; b=l
	6PtvRhdAV0qi2d8e9JUkK2fFLlwxNVY88bcJ+5Aj5gdngpmAYCMSgprFJ8wo710r
	L3GX7fLDfky6/oZ5HVFMbvr3LfslQE3A4w7QmId8Pn6hgVlensKX8wbHDxXJXMEw
	ljaGdMaWuSttqpLIh1kRGvTz2JKn9ccjs3FegrO0y+RbRlkAzKbQ2dqj069GeO+7
	KiNB7ReoNHH0ZUF3RSAIMtQSTjbO3t+zGQmSf4gQWGO8/uy+Wvbs6Xl2gDkoDMV7
	CmCc8Ljjg46b8emiC9vxMTJkV1Aw2OeUhRq5fNYVA+WvlRG7ZcpAMzEUPYx0xvod
	o+8ewgiMwgBexztrVjN5Q==
X-ME-Sender: <xms:SXRTar8WT3jXuGcKhip6v_oZ_ev_MYJ3TiCDPsHDGOy_4qyk61nOpA>
    <xme:SXRTaigdv70_fhLJe4evVFXvY38h-PROEIkCw6nfAYtcRrN4q0volhQFULkdIqZ6L
    z8_glaP7Vjxtth72FHcVVja1cD22b3GdPb5JUl06P7cs54F9UBgiclm>
X-ME-Proxy-Cause: dmFkZTGLo78njPg/nVe+uHWg3AzWojEtguj4DH8KNv19gE9YnhOLAIWMCTf4qhQuAaKC9P
    oqyQsM8pSAEKHb797BqDSo1aNsM3rLblcv7PG7RotKu6L/VmYg2dW8zs2GiGwBQBqITK1u
    X7zWoJgFJCv+6+BhbAHafVgja8Z3pTN2uEr2UPDO/nE22eQsOCXiJJSQPkNMNg99Cf35b5
    J+tdL50vwyZ/VB0b7S4W+UsY7ZTc+cfBHJYz0U/kX691quZfggwKD0RgbG/U6czrjHfrvF
    6fq/4yXwXeSj8YJFVVakjVNKSPD+23ViVy8tbJNIxUaNcajIR7AH0T/de5rCVSDzK344tx
    U0x24Up+ufBa9p+NAvwC4cO2T9HS+kz0KnK//dY/mOxOe/QpD8tgteUxcBF++TLDigfVC1
    C3EJFOtWxRFUioYMCn8qg0rQx+yCJX0thmaTY7UEVDucc/9mhpzue03w8Dp+CxjgmXdcGu
    RSCzsnIT3+hEirvAmIyFtq70pAE1IonG2VSteXv8IfwRKlnb463XanbbZobuFZ9GMPY1GC
    8nsnv82zjPtzkRalpSto4MmL5kHeehrV6iIR1EmzKUc5FkQFY5TKbxBu61Nz8jJ7suNzU3
    Cyvv5MNgqU18rt3jpb2tgZMGlm2/SgzvbBaj3jXxb82AJ7qi2ot7EKTwTDoQ
X-ME-Proxy: <xmx:SXRTapHAhWRiFbB-4amYjFgmwydjtOdojLMQlh0VZZlQEErKhomHig>
    <xmx:SXRTaoKLDK9Ecbgry1ger4QfqGLLQ1xOkTzua4qZzvVI-kaPbzgKWw>
    <xmx:SXRTap8dLyvqloUGHlP29AnEVqPiM2OIYq0126wYr_cBo0x_TFVHVA>
    <xmx:SXRTaqegpYaBne9K3glgOErxceihkfr_b7_lWpHaESTvei9pJ8qgGA>
    <xmx:THRTagApbQu8pd3LegvnC51UZb7KkVStZc2jhlRfHD_OxzYfyYsDaYFF>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 29B00182007E; Sun, 12 Jul 2026 07:02:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ARmmoW1aQeCk
Date: Sun, 12 Jul 2026 13:01:52 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Fernando Fernandez Mancera" <fmancera@suse.de>,
 Netdev <netdev@vger.kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "David Ahern" <dsahern@kernel.org>,
 "Simon Horman" <horms@kernel.org>, "Ido Schimmel" <idosch@nvidia.com>,
 "Jason Gunthorpe" <jgg@ziepe.ca>, "Leon Romanovsky" <leon@kernel.org>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>,
 "Anthony L Nguyen" <anthony.l.nguyen@intel.com>,
 "Przemek Kitszel" <przemyslaw.kitszel@intel.com>,
 "Elad Nachman" <enachman@marvell.com>,
 "Saeed Mahameed" <saeedm@nvidia.com>, "Tariq Toukan" <tariqt@nvidia.com>,
 "Mark Bloch" <mbloch@nvidia.com>, "Petr Machata" <petrm@nvidia.com>,
 "Edward Cree" <ecree.xilinx@gmail.com>,
 "Maxime Coquelin" <mcoquelin.stm32@gmail.com>,
 "Alexandre Torgue" <alexandre.torgue@foss.st.com>,
 "Arend van Spriel" <arend.vanspriel@broadcom.com>,
 "Miri Korenblit" <miriam.rachel.korenblit@intel.com>,
 "Keith Busch" <kbusch@kernel.org>, "Jens Axboe" <axboe@kernel.dk>,
 "Christoph Hellwig" <hch@lst.de>, "Sagi Grimberg" <sagi@grimberg.me>,
 "Chaitanya Kulkarni" <kch@nvidia.com>,
 "Saurav Kashyap" <skashyap@marvell.com>,
 "Javed Hasan" <jhasan@marvell.com>,
 GR-QLogic-Storage-Upstream@marvell.com,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Nilesh Javali" <njavali@marvell.com>,
 "Manish Rangankar" <mrangankar@marvell.com>,
 "Varun Prakash" <varun@chelsio.com>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "David Howells" <dhowells@redhat.com>,
 "Marc Dionne" <marc.dionne@auristor.com>,
 "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Chuck Lever" <cel@kernel.org>,
 "Jeff Layton" <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 "Marek Lindner" <marek.lindner@mailbox.org>,
 "Simon Wunderlich" <sw@simonwunderlich.de>,
 "Antonio Quartulli" <antonio@mandelbit.com>,
 "Sven Eckelmann" <sven@narfation.org>,
 "Nikolay Aleksandrov" <razor@blackwall.org>,
 "Pablo Neira Ayuso" <pablo@netfilter.org>,
 "Florian Westphal" <fw@strlen.de>, "Phil Sutter" <phil@nwl.cc>,
 "Johannes Berg" <johannes@sipsolutions.net>,
 "Matthieu Baerts" <matttbe@kernel.org>,
 "Mat Martineau" <martineau@kernel.org>,
 "Geliang Tang" <geliang@kernel.org>, "Julian Anastasov" <ja@ssi.bg>,
 "Aaron Conole" <aconole@redhat.com>,
 "Eelco Chaudron" <echaudro@redhat.com>,
 "Ilya Maximets" <i.maximets@ovn.org>,
 "Allison Henderson" <achender@kernel.org>,
 "Jamal Hadi Salim" <jhs@mojatatu.com>, "Jiri Pirko" <jiri@resnulli.us>,
 "Marcelo Ricardo Leitner" <marcelo.leitner@gmail.com>,
 "Xin Long" <lucien.xin@gmail.com>,
 "D. Wythe" <alibuda@linux.alibaba.com>,
 "Dust Li" <dust.li@linux.alibaba.com>,
 "Sidraya Jayagond" <sidraya@linux.ibm.com>,
 "Wenjia Zhang" <wenjia@linux.ibm.com>,
 "Mahanta Jambigi" <mjambigi@linux.ibm.com>,
 "Tony Lu" <tonylu@linux.alibaba.com>, "Wen Gu" <guwen@linux.alibaba.com>,
 "Jon Maloy" <jmaloy@redhat.com>,
 "Steffen Klassert" <steffen.klassert@secunet.com>,
 "Herbert Xu" <herbert@gondor.apana.org.au>,
 "Vikas Gupta" <vikas.gupta@broadcom.com>,
 "Rajashekar Hudumula" <rajashekar.hudumula@broadcom.com>,
 "Justin Chen" <justin.chen@broadcom.com>,
 "Bhargava Marreddy" <bhargava.marreddy@broadcom.com>,
 "Nicolai Buchwitz" <nb@tipi-net.de>,
 "Florian Fainelli" <florian.fainelli@broadcom.com>,
 "Heiner Kallweit" <hkallweit1@gmail.com>,
 "Krzysztof Kozlowski" <krzk@kernel.org>,
 "Russell King" <rmk+kernel@armlinux.org.uk>, "Yao Zi" <me@ziyao.cc>,
 "Yanteng Si" <siyanteng@cqsoftware.com.cn>,
 "Maxime Chevallier" <maxime.chevallier@bootlin.com>,
 "Julian Braha" <julianbraha@gmail.com>,
 "Joey Lu" <a0987203069@gmail.com>,
 "Shangjuan Wei" <weishangjuan@eswincomputing.com>,
 "Chen-Yu Tsai" <wens@kernel.org>, "Inochi Amaoto" <inochiama@gmail.com>,
 "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 "Qingfang Deng" <qingfang.deng@linux.dev>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Eric Biggers" <ebiggers@kernel.org>,
 "Ethan Nelson-Moore" <enelsonmoore@gmail.com>,
 "Ard Biesheuvel" <ardb@kernel.org>,
 "Dmitry Safonov" <0x7f454c46@gmail.com>,
 "Kuniyuki Iwashima" <kuniyu@google.com>, "Alyssa Ross" <hi@alyssa.is>,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "open list:NETRONOME ETHERNET DRIVERS" <oss-drivers@corigine.com>,
 linux-net-drivers@amd.com, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-wireless@vger.kernel.org,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org,
 "open list:ETHERNET BRIDGE" <bridge@lists.linux.dev>,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 mptcp@lists.linux.dev, lvs-devel@vger.kernel.org, dev@openvswitch.org,
 rds-devel@oss.oracle.com, linux-sctp@vger.kernel.org,
 linux-s390@vger.kernel.org,
 "open list:TIPC NETWORK LAYER" <tipc-discussion@lists.sourceforge.net>
Message-Id: <12ffac6a-649a-4e4a-8d12-0b48171e1d95@app.fastmail.com>
In-Reply-To: <20260712013941.4570-2-fmancera@suse.de>
References: <20260712013941.4570-1-fmancera@suse.de>
 <20260712013941.4570-2-fmancera@suse.de>
Subject: Re: [PATCH 01/13 RFC net-next] net: ipv4: introduce CONFIG_IPV4 to decouple
 the IPv4 stack
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arndb.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[arndb.de:s=fm1,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-1326-lists,linux-sctp=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:fmancera@suse.de,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:dsahern@kernel.org,m:horms@kernel.org,m:idosch@nvidia.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:andrew+netdev@lunn.ch,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:enachman@marvell.com,m:saeedm@nvidia.com,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:petrm@nvidia.com,m:ecree.xilinx@gmail.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:arend.vanspriel@broadcom.com,m:miriam.rachel.korenblit@intel.com,m:kbusch@kernel.org,m:axboe@kernel.dk,m:hch@lst.de,m:sagi@grimberg.me,m:kch@nvidia.com,m:skashyap@marvell.com,m:jhasan@marvell.com,m:GR-QLogic-Storage-Upstream@marvell.com,m:James.Bottomley@hansenpartnership.com,m:martin.petersen@oracle.com,m:njavali@marvell.com,m:mrangankar@marvell.com,m:varun@chelsio.com,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:dhowells@redhat.com,m:marc.dionne@auristor.co
 m,m:trondmy@kernel.org,m:anna@kernel.org,m:cel@kernel.org,m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:marek.lindner@mailbox.org,m:sw@simonwunderlich.de,m:antonio@mandelbit.com,m:sven@narfation.org,m:razor@blackwall.org,m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:johannes@sipsolutions.net,m:matttbe@kernel.org,m:martineau@kernel.org,m:geliang@kernel.org,m:ja@ssi.bg,m:aconole@redhat.com,m:echaudro@redhat.com,m:i.maximets@ovn.org,m:achender@kernel.org,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:marcelo.leitner@gmail.com,m:lucien.xin@gmail.com,m:alibuda@linux.alibaba.com,m:dust.li@linux.alibaba.com,m:sidraya@linux.ibm.com,m:wenjia@linux.ibm.com,m:mjambigi@linux.ibm.com,m:tonylu@linux.alibaba.com,m:guwen@linux.alibaba.com,m:jmaloy@redhat.com,m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:vikas.gupta@broadcom.com,m:rajashekar.hudumula@broadcom.com,m:justin.chen@broadcom.com,m:bhargava.marreddy@broadcom.com,m:nb@t
 ipi-net.de,m:florian.fainelli@broadcom.com,m:hkallweit1@gmail.com,m:krzk@kernel.org,m:rmk+kernel@armlinux.org.uk,m:me@ziyao.cc,m:siyanteng@cqsoftware.com.cn,m:maxime.chevallier@bootlin.com,m:julianbraha@gmail.com,m:a0987203069@gmail.com,m:weishangjuan@eswincomputing.com,m:wens@kernel.org,m:inochiama@gmail.com,m:prabhakar.mahadev-lad.rj@bp.renesas.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[arnd@arndb.de,linux-sctp@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,nvidia.com,ziepe.ca,lunn.ch,intel.com,marvell.com,gmail.com,foss.st.com,broadcom.com,kernel.dk,lst.de,grimberg.me,hansenpartnership.com,oracle.com,chelsio.com,zeniv.linux.org.uk,suse.cz,auristor.com,brown.name,talpey.com,mailbox.org,simonwunderlich.de,mandelbit.com,narfation.org,blackwall.org,netfilter.org,strlen.de,nwl.cc,sipsolutions.net,ssi.bg,ovn.org,mojatatu.com,resnulli.us,linux.alibaba.com,linux.ibm.com,secunet.com,gondor.apana.org.au,tipi-net.de,armlinux.org.uk,ziyao.cc,cqsoftware.com.cn,bootlin.com,eswincomputing.com,bp.renesas.com,linux.dev,linuxfoundation.org,alyssa.is,vger.kernel.org,lists.osuosl.org,corigine.com,amd.com,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev,lists.open-mesh.org,openvswitch.org,oss.oracle.com,lists.sourceforge.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@arndb.de,linux-sctp@vger.kernel.org];
	DKIM_TRACE(0.00)[arndb.de:+,messagingengine.com:+];
	RCPT_COUNT_GT_50(0.00)[134];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-sctp,netdev,kernel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arndb.de:from_mime,arndb.de:dkim,app.fastmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F05CC744722

On Sun, Jul 12, 2026, at 03:38, Fernando Fernandez Mancera wrote:
> Historically, the IPv4 protocol has been linked to the core INET
> subsystem. Because shared infrastructure like the TCP/UDP engine,
> routing or INET hashtables live inside net/ipv4/, it has been impossible
> to compile a kernel with only IPv6 support.
>
> This patch introduces the CONFIG_IPV4 Kconfig symbol, which is set to
> 'def_bool y' for now. This does not allow to completely disable the
> IPv4 stack yet but it lays the necessary build-system work for that
> goal.

I expect this will cause additional (trivial) build regression in the
next step when randconfig builds run into obscure corner cases, either
with INET=y IPV4=n IPV6=y or with INET=y IPV4=n IPV6=n.

I can probably give your patch (with IPV4 visible or disabled) an
early go on the randconfig tree to find these more quickly.
If I run into regressions, should I just add more 'depends on IPV4',
or do you have other plans?

Should we have some logic to ensure that at least one of IPV4 or
IPV6 is enabled? I think this would work

config IPV4
      bool "The IPv4 protocol" if IPV6
      default INET

which only allows turning IPV4 off if IPV6 has enabled.

       Arnd

