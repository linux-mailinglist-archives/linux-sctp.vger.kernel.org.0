Return-Path: <linux-sctp+bounces-358-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED047A477AA
	for <lists+linux-sctp@lfdr.de>; Thu, 27 Feb 2025 09:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E10AC3A9322
	for <lists+linux-sctp@lfdr.de>; Thu, 27 Feb 2025 08:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADAE2236F7;
	Thu, 27 Feb 2025 08:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rtq2K3N7"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7E12206BE;
	Thu, 27 Feb 2025 08:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740644634; cv=none; b=kHOHKQEnITiZdyIH9Jq55zG6v5w3Zz3PXzdxADCyV4uNyo5Mp+vdGhj4N70oXODUehE8juNGQrbd3Ff0+VF67agKgTbCPdM6FzeodnTm0YLWLiyUqJgdCxD3EBQVTT2V5xJK9bfrKMSaqfsu1k2NaypQ+iAHaTDeGSX6+QLb2DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740644634; c=relaxed/simple;
	bh=PdLTmLyeTDgnTiJA/RdFq4UEue65i61KUJwuOFy3wcw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aGKnbhq4fXGMAsDD8hijsmtF/migr1BMFt+GoeNS3mmR5xVC5YPiEsB92qe7K1bKNDiI34w3l+AQQcyxtQTfbzhqh+MPxnt1FHO47QKhA5T+sRZY30YX1Kdz4dTfYAw98BLabrDfIn/13rzd1PD6WJStEU6U51t0HR4WdyyrGaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rtq2K3N7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 839AFC4CEDD;
	Thu, 27 Feb 2025 08:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740644634;
	bh=PdLTmLyeTDgnTiJA/RdFq4UEue65i61KUJwuOFy3wcw=;
	h=From:To:Cc:Subject:Date:From;
	b=rtq2K3N7zkNRXfw5WGz6Yo365HqS+SxHLaTvt4y1rS0t2zbLl2sKJG80TdQMIC1V2
	 Kd7vJhSpMTaN8CbegpqobVEG4oCbYQsq10gRcVLbL22BOvRx38oo834N/vubU1ZzA9
	 vfWGbjLb9OMWeaNslGuAFmBKuKGx5V4TOMGwZq7gQsWW5SkBtFHVCBB83MVqLfNLgP
	 LxsP/j+2t0cFMlMd22xK2q8MNBZsfVHNiuK5KunGxpcdX5QVRX63UozCQ3Vs5W6BNc
	 iP9FOSfrItbaQ/7yi1UvDrooFu9iXaWqpYPCK8alz7I/+sJUgajx9HtETCpEDEos+o
	 wfInmdw4BpZ7g==
From: Geliang Tang <geliang@kernel.org>
To: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	David Ahern <dsahern@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-sctp@vger.kernel.org
Subject: [PATCH net-next 0/4] add sock_kmemdup helper
Date: Thu, 27 Feb 2025 16:23:22 +0800
Message-ID: <cover.1740643844.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

While developing MPTCP BPF path manager [1], I found it's useful to
add a new sock_kmemdup() helper.

My use case is this:

In mptcp_userspace_pm_append_new_local_addr() function (see patch 3
in this patchset), there is a code that uses sock_kmalloc() to
allocate an address entry "e", then immediately duplicate the input
"entry" to it:

	e = sock_kmalloc(sk, sizeof(*e), GFP_ATOMIC);
	if (!e) {
		ret = -ENOMEM;
		goto append_err;
	}
	*e = *entry;

When I implemented MPTCP BPF path manager, I needed to implement a
code similar to this in BPF.

The kfunc sock_kmalloc() can be easily invoked in BPF to allocate
an entry "e", but the code "*e = *entry;" that assigns "entry" to
"e" is not easy to implemented. 

I had to implement such a copy entry helper in BPF:

static void mptcp_pm_copy_addr(struct mptcp_addr_info *dst,
                               struct mptcp_addr_info *src)
{
       dst->id = src->id;
       dst->family = src->family;
       dst->port = src->port;

       if (src->family == AF_INET) {
               dst->addr.s_addr = src->addr.s_addr;
       } else if (src->family == AF_INET6) {
               dst->addr6.s6_addr32[0] = src->addr6.s6_addr32[0];
               dst->addr6.s6_addr32[1] = src->addr6.s6_addr32[1];
               dst->addr6.s6_addr32[2] = src->addr6.s6_addr32[2];
               dst->addr6.s6_addr32[3] = src->addr6.s6_addr32[3];
       }
}

static void mptcp_pm_copy_entry(struct mptcp_pm_addr_entry *dst,
                                struct mptcp_pm_addr_entry *src)
{
       mptcp_pm_copy_addr(&dst->addr, &src->addr);

       dst->flags = src->flags;
       dst->ifindex = src->ifindex;
}

And add write permission for BPF to each field of mptcp_pm_addr_entry:

@@ -74,24 +74,6 @@ static int bpf_mptcp_pm_btf_struct_access(struct bpf_verifier_log *log,
               case offsetof(struct mptcp_pm_addr_entry, addr.port):
                       end = offsetofend(struct mptcp_pm_addr_entry, addr.port);
                       break;
#if IS_ENABLED(CONFIG_MPTCP_IPV6)
               case offsetof(struct mptcp_pm_addr_entry, addr.addr6.s6_addr32[0]):
                       end = offsetofend(struct mptcp_pm_addr_entry, addr.addr6.s6_addr32[0]);
                       break;
               case offsetof(struct mptcp_pm_addr_entry, addr.addr6.s6_addr32[1]):
                       end = offsetofend(struct mptcp_pm_addr_entry, addr.addr6.s6_addr32[1]);
                       break;
               case offsetof(struct mptcp_pm_addr_entry, addr.addr6.s6_addr32[2]):
                       end = offsetofend(struct mptcp_pm_addr_entry, addr.addr6.s6_addr32[2]);
                       break;
               case offsetof(struct mptcp_pm_addr_entry, addr.addr6.s6_addr32[3]):
                       end = offsetofend(struct mptcp_pm_addr_entry, addr.addr6.s6_addr32[3]);
                       break;
#else
               case offsetof(struct mptcp_pm_addr_entry, addr.addr.s_addr):
                       end = offsetofend(struct mptcp_pm_addr_entry, addr.addr.s_addr);
                       break;
#endif


But if there's a sock_kmemdup() helper, it will become much simpler,
only need to call kfunc sock_kmemdup() instead in BPF.

So this patchset adds this new helper and uses it in several places.

[1]
https://patchwork.kernel.org/project/mptcp/cover/cover.1738924875.git.tanggeliang@kylinos.cn/

Geliang Tang (4):
  sock: add sock_kmemdup helper
  net: use sock_kmemdup for ip_options
  mptcp: use sock_kmemdup for address entry
  net/tcp_ao: use sock_kmemdup for tcp_ao_key

 include/net/sock.h       |  2 ++
 net/core/sock.c          | 15 +++++++++++++++
 net/ipv4/tcp_ao.c        |  3 +--
 net/ipv6/exthdrs.c       |  3 +--
 net/mptcp/pm_userspace.c |  3 +--
 net/mptcp/protocol.c     |  7 ++-----
 net/sctp/protocol.c      |  7 ++-----
 7 files changed, 24 insertions(+), 16 deletions(-)

-- 
2.43.0


