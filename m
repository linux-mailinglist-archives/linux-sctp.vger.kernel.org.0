Return-Path: <linux-sctp+bounces-616-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA68B2B311
	for <lists+linux-sctp@lfdr.de>; Mon, 18 Aug 2025 22:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B693A3AF87F
	for <lists+linux-sctp@lfdr.de>; Mon, 18 Aug 2025 20:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95AE273809;
	Mon, 18 Aug 2025 20:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZIcphQwT"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB782737E3;
	Mon, 18 Aug 2025 20:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755550639; cv=none; b=NPippn7mDWR/dMLL3/npzf4P4Ix8geOTZIqvcCA0o62Z/FWnOCP47upRUhnOMhE1zOwH1QZZLOMN6q6GiPlW5lFxrGhVWVn1Gp6cLgbdhaubJv0GIqFjPytL36dk1G6oVkqT3g8BCN2v0+eiBeW5WI5BJrIDjjoID8FivvqsQ50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755550639; c=relaxed/simple;
	bh=qNKZ5iqULvJXfXzUqp/2QZB60NMHRXWRcF8evjYyZOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oeovpedT13hU1Q4ZYYLN0CQ9SgrQ1qFPwJ/YqkbYmYA7rgoPDQNwouaaqh0ERQWcDkJEt6gwEnlaAGRCBg25cCJqfZ+LXWkOz2OAeVVUtaegsAqqJZr43wJdklxoaMy9JCsp1gFvqhMEmaLTeD5s2uNESAZmumdiJK7RJC8u7sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZIcphQwT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA878C116C6;
	Mon, 18 Aug 2025 20:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755550638;
	bh=qNKZ5iqULvJXfXzUqp/2QZB60NMHRXWRcF8evjYyZOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZIcphQwT+cuK7JMBGVqwumdNnu9Sm+dac9ljeGfslDYP0THQgyud+/e2zxKyoPr6s
	 X93EHGn2p0sMgWMvU9NT7KNa/8+fs+qKAnwshtbLN4MoPZYhLhWoEJI5+hon/nb4NY
	 SOdCKhsFHWVbAfjBMDIb1+aVDi105icHi6DAEfQCoXfTS735IY19P4uG5u3xawOB8p
	 EW0YYzeF4eckid3ygYKHQQO8+HHrLerFPpEYPm+dZx3k1+0VWZti6Hk/1noOQLMKS5
	 oB3LxLUpu+Sx0MpY/IAm1D1LqVsC46Y9JNWiwYLAFzdrOjYf0p8xAVoUHCEV3uU757
	 iV35Anm7RGi2w==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	Xin Long <lucien.xin@gmail.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: linux-crypto@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH net-next v3 1/5] selftests: net: Explicitly enable CONFIG_CRYPTO_SHA1 for IPsec
Date: Mon, 18 Aug 2025 13:54:22 -0700
Message-ID: <20250818205426.30222-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818205426.30222-1-ebiggers@kernel.org>
References: <20250818205426.30222-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xfrm_policy.sh, nft_flowtable.sh, and vrf-xfrm-tests.sh use 'ip xfrm'
with SHA-1, either 'auth sha1' or 'auth-trunc hmac(sha1)'.  That
requires CONFIG_CRYPTO_SHA1, which CONFIG_INET_ESP intentionally doesn't
select (as per its help text).  Previously, the config for these tests
relied on CONFIG_CRYPTO_SHA1 being selected by the unrelated option
CONFIG_IP_SCTP.  Since CONFIG_IP_SCTP is being changed to no longer do
that, instead add CONFIG_CRYPTO_SHA1 to the configs explicitly.

Reported-by: Paolo Abeni <pabeni@redhat.com>
Closes: https://lore.kernel.org/r/766e4508-aaba-4cdc-92b4-e116e52ae13b@redhat.com
Suggested-by: Florian Westphal <fw@strlen.de>
Acked-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 tools/testing/selftests/net/config           | 1 +
 tools/testing/selftests/net/netfilter/config | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index c24417d0047bb..d548611e2698e 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -24,10 +24,11 @@ CONFIG_VLAN_8021Q=y
 CONFIG_GENEVE=m
 CONFIG_IFB=y
 CONFIG_INET_DIAG=y
 CONFIG_INET_ESP=y
 CONFIG_INET_ESP_OFFLOAD=y
+CONFIG_CRYPTO_SHA1=y
 CONFIG_NET_FOU=y
 CONFIG_NET_FOU_IP_TUNNELS=y
 CONFIG_NETFILTER=y
 CONFIG_NETFILTER_ADVANCED=y
 CONFIG_NETFILTER_XTABLES_LEGACY=y
diff --git a/tools/testing/selftests/net/netfilter/config b/tools/testing/selftests/net/netfilter/config
index 79d5b33966ba1..305e46b819cbe 100644
--- a/tools/testing/selftests/net/netfilter/config
+++ b/tools/testing/selftests/net/netfilter/config
@@ -11,10 +11,11 @@ CONFIG_BRIDGE_NETFILTER=m
 CONFIG_BRIDGE_NF_EBTABLES=m
 CONFIG_BRIDGE_VLAN_FILTERING=y
 CONFIG_CGROUP_BPF=y
 CONFIG_DUMMY=m
 CONFIG_INET_ESP=m
+CONFIG_CRYPTO_SHA1=m
 CONFIG_IP_NF_MATCH_RPFILTER=m
 CONFIG_IP6_NF_MATCH_RPFILTER=m
 CONFIG_IP_NF_IPTABLES=m
 CONFIG_IP_NF_IPTABLES_LEGACY=m
 CONFIG_IP6_NF_IPTABLES=m
-- 
2.50.1


