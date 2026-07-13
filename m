Return-Path: <linux-sctp+bounces-1334-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vNptFrj+VGpeigAAu9opvQ
	(envelope-from <linux-sctp+bounces-1334-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Mon, 13 Jul 2026 17:05:28 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D1C74CC5A
	for <lists+linux-sctp@lfdr.de>; Mon, 13 Jul 2026 17:05:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mUOJSina;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=soR5R82M;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=QCgcM+Km;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Qj912vQy;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1334-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1334-lists+linux-sctp=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B31B430AD4FF
	for <lists+linux-sctp@lfdr.de>; Mon, 13 Jul 2026 14:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4127C43D4F7;
	Mon, 13 Jul 2026 14:57:29 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE8E43746A
	for <linux-sctp@vger.kernel.org>; Mon, 13 Jul 2026 14:57:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783954649; cv=none; b=YcRE8iB/r/yTXvNJ0wWsN+sgTfwsb0aMhDQw21bEX5wVnU63x3tgHBZlz7MlxM9pIjaK7cvOBsljEsCqseP/xgSvm89Vaz0yyMr8ET11WV++6CBQqCi76wRyCqfYzLrfGEkKTG0dCQGNq71jTDio3yTVk+RZuitHU5dcDKXURP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783954649; c=relaxed/simple;
	bh=6ABN5gkGY/3/F9k+Yhjq2Bu4+3LHZvglZfQ52vr+EhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r+8LAukea/ASaBTHpdj4igUmi//z7CTARoyYXuP6GFAA2F5ICidfWcMisPGrPSu7YRlYVYcj4vNbpilz0qLjy7Ic1UVXN+RwcQmLB7uTi7ivv//2zzSrrSCNeErq1SzuLxU5aylaMyOHAbdH27MjFwviI3BZdn56er1o9I7POo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mUOJSina; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=soR5R82M; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QCgcM+Km; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Qj912vQy; arc=none smtp.client-ip=195.135.223.130
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9421477946;
	Mon, 13 Jul 2026 14:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783954643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w87g+D5SReWeuPg85I2R5REzG6jyR6WyeIEK7Oxt9Lo=;
	b=mUOJSinalmE2ffsIONe157EXkZKLQiaoGJH7cUzcDCHJsvyT/YUW6QuDQdlluxQU5zFHak
	5uHtBuxO+EDEO3tY/uW/kT0Q+9CKaedFem3BYOwQZylEsnA3ROaZTnHJoDU9pP31T7KNua
	FLhrxB64E1UoSdV30u6p/XQXxmFjXAE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783954643;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w87g+D5SReWeuPg85I2R5REzG6jyR6WyeIEK7Oxt9Lo=;
	b=soR5R82MF+Mu62i1L4HAbEIJ6vWZYBeWi31SZE979/ua2yD3lsy6IUUD318V2ruAhjzKga
	HyBGeXDFxDaXaiAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783954642; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w87g+D5SReWeuPg85I2R5REzG6jyR6WyeIEK7Oxt9Lo=;
	b=QCgcM+Km5SZY8NOHjlCw3HosC8zS+PF0scHR2IwLdplL87Eaem5ybUMwG87hdA1rjngrmv
	jfc2mqfXpfb9US5KoGmzJi4CuAqmiNBxt9mvN6apbKj7smPvowzdTcGXq+YNh7slMzW9Ry
	eebKIgGCE6urB9kYpA+nMZpQoDQl6tw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783954642;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w87g+D5SReWeuPg85I2R5REzG6jyR6WyeIEK7Oxt9Lo=;
	b=Qj912vQywvUs7wBqJ2BfrXiTmJvI4xAWx3e/pTEHECGFv+xcUxTb2o5xyu7np2AqVZnxUQ
	B7mpilofPRlrSBAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9F73A779AE;
	Mon, 13 Jul 2026 14:57:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jkEmIMX8VGogSgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 13 Jul 2026 14:57:09 +0000
Message-ID: <d126eb95-4f57-43f7-8cde-31f201d3dad0@suse.de>
Date: Mon, 13 Jul 2026 16:57:02 +0200
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13 RFC net-next] net: ipv4: introduce CONFIG_IPV4 to
 decouple the IPv4 stack
To: Arnd Bergmann <arnd@arndb.de>, Netdev <netdev@vger.kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
 Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Anthony L Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Elad Nachman <enachman@marvell.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Petr Machata <petrm@nvidia.com>, Edward Cree <ecree.xilinx@gmail.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Arend van Spriel <arend.vanspriel@broadcom.com>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Saurav Kashyap <skashyap@marvell.com>,
 Javed Hasan <jhasan@marvell.com>, GR-QLogic-Storage-Upstream@marvell.com,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Nilesh Javali <njavali@marvell.com>,
 Manish Rangankar <mrangankar@marvell.com>, Varun Prakash
 <varun@chelsio.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 Marek Lindner <marek.lindner@mailbox.org>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Antonio Quartulli <antonio@mandelbit.com>,
 Sven Eckelmann <sven@narfation.org>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>,
 Phil Sutter <phil@nwl.cc>, Johannes Berg <johannes@sipsolutions.net>,
 Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>,
 Geliang Tang <geliang@kernel.org>, Julian Anastasov <ja@ssi.bg>,
 Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>,
 Ilya Maximets <i.maximets@ovn.org>, Allison Henderson <achender@kernel.org>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Xin Long <lucien.xin@gmail.com>, "D. Wythe" <alibuda@linux.alibaba.com>,
 Dust Li <dust.li@linux.alibaba.com>, Sidraya Jayagond
 <sidraya@linux.ibm.com>, Wenjia Zhang <wenjia@linux.ibm.com>,
 Mahanta Jambigi <mjambigi@linux.ibm.com>, Tony Lu
 <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
 Jon Maloy <jmaloy@redhat.com>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Vikas Gupta <vikas.gupta@broadcom.com>,
 Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>,
 Justin Chen <justin.chen@broadcom.com>,
 Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
 Nicolai Buchwitz <nb@tipi-net.de>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Krzysztof Kozlowski
 <krzk@kernel.org>, Russell King <rmk+kernel@armlinux.org.uk>,
 Yao Zi <me@ziyao.cc>, Yanteng Si <siyanteng@cqsoftware.com.cn>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Julian Braha <julianbraha@gmail.com>, Joey Lu <a0987203069@gmail.com>,
 Shangjuan Wei <weishangjuan@eswincomputing.com>,
 Chen-Yu Tsai <wens@kernel.org>, Inochi Amaoto <inochiama@gmail.com>,
 "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Qingfang Deng <qingfang.deng@linux.dev>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Eric Biggers <ebiggers@kernel.org>,
 Ethan Nelson-Moore <enelsonmoore@gmail.com>, Ard Biesheuvel
 <ardb@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Alyssa Ross <hi@alyssa.is>,
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
References: <20260712013941.4570-1-fmancera@suse.de>
 <20260712013941.4570-2-fmancera@suse.de>
 <12ffac6a-649a-4e4a-8d12-0b48171e1d95@app.fastmail.com>
 <2256daf4-d03c-4a57-9d72-7a388d823f18@suse.de>
 <713178ff-0fb2-4f1b-90bc-9841cd42c20e@app.fastmail.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <713178ff-0fb2-4f1b-90bc-9841cd42c20e@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -0.80
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,nvidia.com,ziepe.ca,lunn.ch,intel.com,marvell.com,gmail.com,foss.st.com,broadcom.com,kernel.dk,lst.de,grimberg.me,hansenpartnership.com,oracle.com,chelsio.com,zeniv.linux.org.uk,suse.cz,auristor.com,brown.name,talpey.com,mailbox.org,simonwunderlich.de,mandelbit.com,narfation.org,blackwall.org,netfilter.org,strlen.de,nwl.cc,sipsolutions.net,ssi.bg,ovn.org,mojatatu.com,resnulli.us,linux.alibaba.com,linux.ibm.com,secunet.com,gondor.apana.org.au,tipi-net.de,armlinux.org.uk,ziyao.cc,cqsoftware.com.cn,bootlin.com,eswincomputing.com,bp.renesas.com,linux.dev,linuxfoundation.org,alyssa.is,vger.kernel.org,lists.osuosl.org,corigine.com,amd.com,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev,lists.open-mesh.org,openvswitch.org,oss.oracle.com,lists.sourceforge.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[fmancera@suse.de,linux-sctp@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-1334-lists,linux-sctp=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:arnd@arndb.de,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:dsahern@kernel.org,m:horms@kernel.org,m:idosch@nvidia.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:andrew+netdev@lunn.ch,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:enachman@marvell.com,m:saeedm@nvidia.com,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:petrm@nvidia.com,m:ecree.xilinx@gmail.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:arend.vanspriel@broadcom.com,m:miriam.rachel.korenblit@intel.com,m:kbusch@kernel.org,m:axboe@kernel.dk,m:hch@lst.de,m:sagi@grimberg.me,m:kch@nvidia.com,m:skashyap@marvell.com,m:jhasan@marvell.com,m:GR-QLogic-Storage-Upstream@marvell.com,m:James.Bottomley@hansenpartnership.com,m:martin.petersen@oracle.com,m:njavali@marvell.com,m:mrangankar@marvell.com,m:varun@chelsio.com,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:dhowells@redhat.com,m:marc.dionne@auristor.com,m
 :trondmy@kernel.org,m:anna@kernel.org,m:cel@kernel.org,m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:marek.lindner@mailbox.org,m:sw@simonwunderlich.de,m:antonio@mandelbit.com,m:sven@narfation.org,m:razor@blackwall.org,m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:johannes@sipsolutions.net,m:matttbe@kernel.org,m:martineau@kernel.org,m:geliang@kernel.org,m:ja@ssi.bg,m:aconole@redhat.com,m:echaudro@redhat.com,m:i.maximets@ovn.org,m:achender@kernel.org,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:marcelo.leitner@gmail.com,m:lucien.xin@gmail.com,m:alibuda@linux.alibaba.com,m:dust.li@linux.alibaba.com,m:sidraya@linux.ibm.com,m:wenjia@linux.ibm.com,m:mjambigi@linux.ibm.com,m:tonylu@linux.alibaba.com,m:guwen@linux.alibaba.com,m:jmaloy@redhat.com,m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:vikas.gupta@broadcom.com,m:rajashekar.hudumula@broadcom.com,m:justin.chen@broadcom.com,m:bhargava.marreddy@broadcom.com,m:nb@tipi
 -net.de,m:florian.fainelli@broadcom.com,m:hkallweit1@gmail.com,m:krzk@kernel.org,m:rmk+kernel@armlinux.org.uk,m:me@ziyao.cc,m:siyanteng@cqsoftware.com.cn,m:maxime.chevallier@bootlin.com,m:julianbraha@gmail.com,m:a0987203069@gmail.com,m:weishangjuan@eswincomputing.com,m:wens@kernel.org,m:inochiama@gmail.com,m:prabhakar.mahadev-lad.rj@bp.renesas.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,linux-sctp@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_GT_50(0.00)[134];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp,netdev,kernel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C2D1C74CC5A

On 7/13/26 4:22 PM, Arnd Bergmann wrote:
> On Mon, Jul 13, 2026, at 16:00, Fernando Fernandez Mancera wrote:
>> On 7/12/26 1:01 PM, Arnd Bergmann wrote:
>>> On Sun, Jul 12, 2026, at 03:38, Fernando Fernandez Mancera wrote:
>>>> Historically, the IPv4 protocol has been linked to the core INET
>>>> subsystem. Because shared infrastructure like the TCP/UDP engine,
>>>> routing or INET hashtables live inside net/ipv4/, it has been impossible
>>>> to compile a kernel with only IPv6 support.
>>>>
>>>> This patch introduces the CONFIG_IPV4 Kconfig symbol, which is set to
>>>> 'def_bool y' for now. This does not allow to completely disable the
>>>> IPv4 stack yet but it lays the necessary build-system work for that
>>>> goal.
>>>
>>> I expect this will cause additional (trivial) build regression in the
>>> next step when randconfig builds run into obscure corner cases, either
>>> with INET=y IPV4=n IPV6=y or with INET=y IPV4=n IPV6=n.
>>>
>>> I can probably give your patch (with IPV4 visible or disabled) an
>>> early go on the randconfig tree to find these more quickly.
>>> If I run into regressions, should I just add more 'depends on IPV4',
>>> or do you have other plans?
>>>
>>
>> Yes, I have a job running randconfig and verifying nothing breaks. If
>> something breaks and it isn't core networking stack I would just make
>> the Kconfig symbol depend on IPv4.
>>
>> Then later we will have more time to write a dedicate patch so it does
>> not depend on IPv4.
> 
> Ok
> 
>>> Should we have some logic to ensure that at least one of IPV4 or
>>> IPV6 is enabled? I think this would work
>>>
>>> config IPV4
>>>         bool "The IPv4 protocol" if IPV6
>>>         default INET
>>>
>>> which only allows turning IPV4 off if IPV6 has enabled.
>>>
>>
>> I do wonder, should we? I mean, I didn't try it off but I don't see why
>> we should not allow a pure L2 system..
> 
> I expected a pure L2 system to be CONFIG_ETHERNET=y CONFIG_INET=n.
> 
> Which user-visible parts of CONFIG_INET would you want keep working
> when both v4 and v6 are disabled?
> 

Yes, you are right. So I think introducing something as you proposed 
makes sense. Right now I cannot think about something needed from INET 
for pure L2.

Thank you!
Fernando.

