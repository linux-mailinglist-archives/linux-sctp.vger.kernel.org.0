Return-Path: <linux-sctp+bounces-587-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D42F6B0E275
	for <lists+linux-sctp@lfdr.de>; Tue, 22 Jul 2025 19:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF4A03B4BB6
	for <lists+linux-sctp@lfdr.de>; Tue, 22 Jul 2025 17:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F65827F749;
	Tue, 22 Jul 2025 17:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yubgvth6"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AC427F163;
	Tue, 22 Jul 2025 17:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753204717; cv=none; b=oCzlp+A/vEdCLPOG/T1kwrjmRnYU6qLSxjqbk39VavyVt0PmQkYBTh3AQb35QvViQjnt7FrIdYYYBRVe74ZbYbMihuxVZiguGjxYhgRAiaErl0mZAeUt+lD51AXQzJDh8x5XQElrL9RRpCd7SeJ+wKTVbC/m9afgzdpw5PVQOig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753204717; c=relaxed/simple;
	bh=NvGUedlgGRAEontrfaw0U9b4fEu2DOIryQsyYB8jpX0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DuV8v+w0k8/xEM2sWVj7kqP4/OBsnn9uHKZy6Mle18gO4+tiCZZ1zb3kzzGNAXb37PlGhWXRDPcN1IV7vGnkA4SqYYtpEnnHuJsyT77B8EZqhtSuniL8F/vO8cqAy8vE4kaxlFceuSo+Z6bMFtmiQK4r+5/xv7Yczksp0ojyNvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yubgvth6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5751DC4CEEB;
	Tue, 22 Jul 2025 17:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753204716;
	bh=NvGUedlgGRAEontrfaw0U9b4fEu2DOIryQsyYB8jpX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yubgvth6Hpq9EcmCxPU+AobdsX97G3PXw/ufNb3M2CjzTZOo8V1yyFIGD5OwBcKed
	 DCj8TZ/feL0gAnB55pTTyF1lvPy5tnZJw50LiRWq4083OgXWloU9K5FlMiZ/br+wE3
	 uVlU5FtuSHDySkHdhdyCuNtSaUxlAomX3u7rj/1epxiW99lJF0auaYBERu/pIAFsZL
	 KYWpTkDjVL5rTn/3IQCwC3uAakKo9iiwD0mConN+XCYeBm1Srkf133WKpVkVJmxosF
	 dQYG4ABQZcRToF4Y+5LPsVKKnuOKTZeYucoJf714U6zktFxGv3dUt88ceoiZVWd7SY
	 WdR0ljyPBoChA==
From: Kees Cook <kees@kernel.org>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: Kees Cook <kees@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Xin Long <lucien.xin@gmail.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org,
	linux-sctp@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH net-next 1/3] ipv6: Add sockaddr_inet unified address structure
Date: Tue, 22 Jul 2025 10:18:31 -0700
Message-Id: <20250722171836.1078436-1-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722171528.work.209-kees@kernel.org>
References: <20250722171528.work.209-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2274; i=kees@kernel.org; h=from:subject; bh=NvGUedlgGRAEontrfaw0U9b4fEu2DOIryQsyYB8jpX0=; b=owGbwMvMwCVmps19z/KJym7G02pJDBn1x19E3rVqcHt++ryf//UFt+bwOotW8+2fUpHYmzevz EPj7uzEjlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgIkkxDD8lX/N1971+ZH2zTBh bT8dR5HUsORX3A0+Eakl/0J6py28zfA/sb1eZqJ60Z4vbFytD4oa1tf/373vobPRx4ciqn5BG2c wAwA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

There are cases in networking (e.g. wireguard, sctp) where a union is
used to provide coverage for either IPv4 or IPv6 network addresses,
and they include an embedded "struct sockaddr" as well (for "sa_family"
and raw "sa_data" access). The current struct sockaddr contains a
flexible array, which means these unions should not be further embedded
in other structs because they do not technically have a fixed size (and
are generating warnings for the coming -Wflexible-array-not-at-end flag
addition). But the future changes to make struct sockaddr a fixed size
(i.e. with a 14 byte sa_data member) make the "sa_data" uses with an IPv6
address a potential place for the compiler to get upset about object size
mismatches. Therefore, we need a sockaddr that cleanly provides both an
sa_family member and an appropriately fixed-sized sa_data member that does
not bloat member usage via the potential alternative of sockaddr_storage
to cover both IPv4 and IPv6, to avoid unseemly churn in the affected code
bases.

Introduce sockaddr_inet as a unified structure for holding both IPv4 and
IPv6 addresses (i.e. large enough to accommodate sockaddr_in6).

The structure is defined in linux/in6.h since its max size is sized
based on sockaddr_in6 and provides a more specific alternative to the
generic sockaddr_storage for IPv4 with IPv6 address family handling.

The "sa_family" member doesn't use the sa_family_t type to avoid needing
layer violating header inclusions.

Signed-off-by: Kees Cook <kees@kernel.org>
---
 include/linux/in6.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/in6.h b/include/linux/in6.h
index 0777a21cbf86..403f926d33d8 100644
--- a/include/linux/in6.h
+++ b/include/linux/in6.h
@@ -18,6 +18,13 @@
 
 #include <uapi/linux/in6.h>
 
+/* Large enough to hold both sockaddr_in and sockaddr_in6. */
+struct sockaddr_inet {
+	unsigned short	sa_family;
+	char		sa_data[sizeof(struct sockaddr_in6) -
+				sizeof(unsigned short)];
+};
+
 /* IPv6 Wildcard Address (::) and Loopback Address (::1) defined in RFC2553
  * NOTE: Be aware the IN6ADDR_* constants and in6addr_* externals are defined
  * in network byte order, not in host byte order as are the IPv4 equivalents
-- 
2.34.1


