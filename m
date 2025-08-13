Return-Path: <linux-sctp+bounces-605-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B44B23F3F
	for <lists+linux-sctp@lfdr.de>; Wed, 13 Aug 2025 06:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9ACA57A4D8B
	for <lists+linux-sctp@lfdr.de>; Wed, 13 Aug 2025 04:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB7C2BE039;
	Wed, 13 Aug 2025 04:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEKj3Mt6"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB102BD5B9;
	Wed, 13 Aug 2025 04:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755057802; cv=none; b=k4uxTy3IL0K++KvGxMwa1uifMXIctpjoQ0xSCCHMk0qRX4DoWgXt5e4/2ufxEDTgwLXsTShPz2o7PsSPunwaZmz12bxJ43FXVLeuJwMOJERmRh+x7D/ulGK6cwPHUpQ0hmcjSF9vMR3A/tvFA8gF2+bjm1MjFzyQfkL01r1iD8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755057802; c=relaxed/simple;
	bh=zMru5WPidSuMLC0DSQMXmt2rf9QL80waEtC41YUBmqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gaa/xSZJIoB4Ong4jCN6U45cN2p7GhrzADRB31hxb1LmbCy3Z38Se+37ggIYyhywh8nEMiHQpKkoMGD+/kbn5bMf4iXsH38mK9AXYCzRjdjAwhYnGK7dwOVRYDSw7+UeJKNg//NOOxK+Oo5AcWQOK6jaDK5LKaJStPzaJfOjpZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NEKj3Mt6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97CBAC4CEF7;
	Wed, 13 Aug 2025 04:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755057800;
	bh=zMru5WPidSuMLC0DSQMXmt2rf9QL80waEtC41YUBmqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NEKj3Mt6oXFhcx+R8mnqD+jQn4ClybudKWmhO34XbN/5eKjZi+949FCuL9znW8Sgl
	 PbhKm3gXmDQh31OLDlNybn0b2le5FXdjjbbqshcyzOvjFCQTlcFgez4dOyelwHnBsv
	 Isw95EFkcl1jYqEytOJSHcKveoH2UtzIUOAdMHOAwXTBGW34m9TdbtoY8E4gQKptuf
	 +ws4n1JkQbKgv1MPvAxRem+UQRX/Ic84mKQQ1mZWYuO4UGIHGx/gM2RfS4Wt7JNc4E
	 YM17u1EaoBoPT7UciLHveempkQa48zSBx0P1+EuDvQtPvpUc+Ec4EiZAsuOMvyC3dp
	 uWpYSap/oMWbQ==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	Xin Long <lucien.xin@gmail.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: linux-crypto@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH net-next v2 1/3] selftests: net: Explicitly enable CONFIG_CRYPTO_SHA1 for IPsec
Date: Tue, 12 Aug 2025 21:01:19 -0700
Message-ID: <20250813040121.90609-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250813040121.90609-1-ebiggers@kernel.org>
References: <20250813040121.90609-1-ebiggers@kernel.org>
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


