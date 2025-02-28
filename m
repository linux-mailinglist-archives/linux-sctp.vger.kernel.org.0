Return-Path: <linux-sctp+bounces-367-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 639D0A49675
	for <lists+linux-sctp@lfdr.de>; Fri, 28 Feb 2025 11:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00DC616AE0C
	for <lists+linux-sctp@lfdr.de>; Fri, 28 Feb 2025 10:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162EA25D52B;
	Fri, 28 Feb 2025 10:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kr3e59p4"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE5925D218;
	Fri, 28 Feb 2025 10:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740736907; cv=none; b=k2wtEWr8KMKq0eOl7uEU164E1FLTJuGog8L8bd0dsmZCKHX+/WKbdpyLbhUfzHTLFyaQY9mrLYVyLuTKAzTFZOZrwhdu/Uind7ybfFlerUUGIHBvNKck9bsIJ0WqgqoWWQlXF9sJDBU6MFdMSQfgZRGf349TwogoarrtTQWoc3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740736907; c=relaxed/simple;
	bh=WG2xZI0wmFn+Azmg6PmV3m8qa+1ewbLpbNmj4jiXmJY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MlcnmXUZMfzeOA7lna+Vk3UvIfHt3tNDqicKqX/kXPJoSELrpSDOW23iMpnySi8APm+/D/6jUAs7nL1+WSrlNe5WgPqCKm5P8WGzo88K1AsIqfw3xZfOYKBIOB+xWpQt9P2kXE3UfhfxtF20cM/KodXhrICQhQD1Tegms5HZ10g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kr3e59p4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5372C4CED6;
	Fri, 28 Feb 2025 10:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740736906;
	bh=WG2xZI0wmFn+Azmg6PmV3m8qa+1ewbLpbNmj4jiXmJY=;
	h=From:To:Cc:Subject:Date:From;
	b=Kr3e59p4oI135FiQwVWVoxKHXIKSsF8DyqNcr0YKvSHIIjXUQ2SfNWvnfVjQNCchF
	 6Quo2kp8M+Ny868FIibt3EuhvF0ffx2ZOSZS9g7WKsWpB+oGkUu6ix2OldsMRTYboE
	 5sfAhuWkOdtS7btQS3uVbZme7l6NWHtLJZDDqZysczdO0Dv4Iw7yBBBn3zezhmjnJf
	 vfRxnS9ZUUQlKqufE97DKS8bf1DgTG4VZYprMx3bWYm5nEYd9V0ibvWIKQspg/mf33
	 VEYrY9ySmKFi3LCiGeNVUEjBedgFCv3b3maArlIpqTxTWDxABUYL5WA+FqmTkJaUBA
	 UMFbGIr8ydauw==
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
Subject: [PATCH net-next v2 0/3] add sock_kmemdup helper
Date: Fri, 28 Feb 2025 18:01:30 +0800
Message-ID: <cover.1740735165.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v2:
 - add "EXPORT_SYMBOL(sock_kmemdup)" as Matthieu suggested.
 - drop the patch "use sock_kmemdup for tcp_ao_key".

While developing MPTCP BPF path manager [1], I found it's useful to
add a new sock_kmemdup() helper.

My use case is this:

In mptcp_userspace_pm_append_new_local_addr() function (see patch 3
in this patchset), it uses sock_kmalloc() to allocate an address
entry "e", then immediately duplicate the input "entry" to it:

'''
	e = sock_kmalloc(sk, sizeof(*e), GFP_ATOMIC);
	if (!e) {
		ret = -ENOMEM;
		goto append_err;
	}

	*e = *entry;
'''

When I implemented MPTCP BPF path manager, I needed to implement a
code similar to this in BPF.

The kfunc sock_kmalloc() can be easily invoked in BPF to allocate
an entry "e", but the code "*e = *entry;" that assigns "entry" to
"e" is not easy to implemented. 

I had to implement such a "copy entry" helper in BPF:

'''
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
'''

And add "write permission" for BPF to each field of mptcp_pm_addr_entry:

'''
@@ static int bpf_mptcp_pm_btf_struct_access(struct bpf_verifier_log *log,
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
'''

But if there's a sock_kmemdup() helper, it will become much simpler,
only need to call kfunc sock_kmemdup() instead in BPF.

So this patchset adds this new helper and uses it in several places.

[1]
https://lore.kernel.org/mptcp/cover.1738924875.git.tanggeliang@kylinos.cn/

Geliang Tang (3):
  sock: add sock_kmemdup helper
  net: use sock_kmemdup for ip_options
  mptcp: use sock_kmemdup for address entry

 include/net/sock.h       |  2 ++
 net/core/sock.c          | 16 ++++++++++++++++
 net/ipv6/exthdrs.c       |  3 +--
 net/mptcp/pm_userspace.c |  3 +--
 net/mptcp/protocol.c     |  7 ++-----
 net/sctp/protocol.c      |  7 ++-----
 6 files changed, 24 insertions(+), 14 deletions(-)

-- 
2.43.0


