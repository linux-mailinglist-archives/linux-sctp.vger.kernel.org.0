Return-Path: <linux-sctp+bounces-116-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E177C8B39A9
	for <lists+linux-sctp@lfdr.de>; Fri, 26 Apr 2024 16:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40D30B240D7
	for <lists+linux-sctp@lfdr.de>; Fri, 26 Apr 2024 14:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BC7148851;
	Fri, 26 Apr 2024 14:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7PconPL"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F911474D1;
	Fri, 26 Apr 2024 14:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714141188; cv=none; b=QVJr4o7qL9Sdoh/FpaFgauTC+12exowSnZduA19ovNGXv/6Fm/gIMReucahMFWV1jlQgLUle/IGTZall43ocACczX9ceSeDOZhrVCCA0I+swNioIS66Qlgill7h1+Ow6qLX73zBSH0eNx9Est8JXCnsRTs/LUZ6ayzl0DwiqZyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714141188; c=relaxed/simple;
	bh=1YPIyGpDitR6xzxqcXAI3KlvDHPDnDAVBabxqnFbikg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ga//kroBx8lz6v18UU3ZibbHDAD+Om+y1Taup7v7or7sJjDfCKB2vpgVORX1bc77PQr1lNd7HlnRYjir0yeO3tBclSKDo93hxFUxag8ETrUJf7jmlKbUG+XkHcl9pgVQdtx4H4d+z6Xi5bc0GN0dwKXclKpKr2qIoN8DrFq1hP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7PconPL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E0EDC116B1;
	Fri, 26 Apr 2024 14:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714141187;
	bh=1YPIyGpDitR6xzxqcXAI3KlvDHPDnDAVBabxqnFbikg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B7PconPLHaZbsSE+E2qb7kFxKKPiSGifdJxIO5nhpOcR+i/H6Rf/QpegOYMOrwrIT
	 ZRBYBF7gNYzqS+/qeUumbeqlcHdDGW+dcRhBg8s7V/Bx2ygqJnoWHiS5PphSoESsHY
	 wRLQw4fRqH4m26AoF1Fv5sD5hYTSpNK20oIHkZcB8KD5h1QygEo8apSWV73UV/NctU
	 L4LxYtbi0OBSyEtXylLUnPdQBuisvmnPgFoxGk/57wq4H8Sikhl+RJz0nfdW862a6j
	 ZTEGse7JAdOTZn5tS7OrtXwoHnMwy7yTsx06qEaYDXg2z1j1lkSEKF/9WUoF/Aj8KT
	 kEQlDp7qR5gnA==
Date: Fri, 26 Apr 2024 07:19:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joel Granados <j.granados@samsung.com>
Cc: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Alexander Aring
 <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, Miquel
 Raynal <miquel.raynal@bootlin.com>, David Ahern <dsahern@kernel.org>,
 Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, Matthieu Baerts <matttbe@kernel.org>, Mat
 Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, Ralf
 Baechle <ralf@linux-mips.org>, Remi Denis-Courmont <courmisch@gmail.com>,
 Allison Henderson <allison.henderson@oracle.com>, David Howells
 <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, Marcelo
 Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long
 <lucien.xin@gmail.com>, Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher
 <jaka@linux.ibm.com>, "D. Wythe" <alibuda@linux.alibaba.com>, Tony Lu
 <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>, Trond
 Myklebust <trond.myklebust@hammerspace.com>, Anna Schumaker
 <anna@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, Jeff Layton
 <jlayton@kernel.org>, Neil Brown <neilb@suse.de>, Olga Kornievskaia
 <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey
 <tom@talpey.com>, Jon Maloy <jmaloy@redhat.com>, Ying Xue
 <ying.xue@windriver.com>, Martin Schiller <ms@dev.tdt.de>, Pablo Neira
 Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>,
 Florian Westphal <fw@strlen.de>, Roopa Prabhu <roopa@nvidia.com>, Nikolay
 Aleksandrov <razor@blackwall.org>, Simon Horman <horms@verge.net.au>,
 Julian Anastasov <ja@ssi.bg>, Joerg Reuter <jreuter@yaina.de>, Luis
 Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <dccp@vger.kernel.org>, <linux-wpan@vger.kernel.org>,
 <mptcp@lists.linux.dev>, <linux-hams@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, <rds-devel@oss.oracle.com>,
 <linux-afs@lists.infradead.org>, <linux-sctp@vger.kernel.org>,
 <linux-s390@vger.kernel.org>, <linux-nfs@vger.kernel.org>,
 <tipc-discussion@lists.sourceforge.net>, <linux-x25@vger.kernel.org>,
 <netfilter-devel@vger.kernel.org>, <coreteam@netfilter.org>,
 <bridge@lists.linux.dev>, <lvs-devel@vger.kernel.org>
Subject: Re: [PATCH v4 1/8] net: Remove the now superfluous sentinel
 elements from ctl_table array
Message-ID: <20240426071944.206e9cff@kernel.org>
In-Reply-To: <20240426065931.wyrzevlheburnf47@joelS2.panther.com>
References: <20240425-jag-sysctl_remset_net-v4-0-9e82f985777d@samsung.com>
	<20240425-jag-sysctl_remset_net-v4-1-9e82f985777d@samsung.com>
	<CGME20240425225817eucas1p21d1f3bcedc248575285a74af88e66966@eucas1p2.samsung.com>
	<20240425155804.66f3bed5@kernel.org>
	<20240426065931.wyrzevlheburnf47@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Apr 2024 08:59:31 +0200 Joel Granados wrote:
> Sorry about this. I pulled the trigger way too early. This is already
> fixed in my v4.
> >       |                ^~~~~~~~~~
> > -- 
> > netdev FAQ tl;dr:
> >  - designate your patch to a tree - [PATCH net] or [PATCH net-next]
> >  - for fixes the Fixes: tag is required, regardless of the tree
> >  - don't post large series (> 15 patches), break them up
> >  - don't repost your patches within one 24h period

I guess you didn't bother reading the tl;dr I put in here.. SMH.

