Return-Path: <linux-sctp+bounces-588-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA44BB0E277
	for <lists+linux-sctp@lfdr.de>; Tue, 22 Jul 2025 19:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 141D93B557E
	for <lists+linux-sctp@lfdr.de>; Tue, 22 Jul 2025 17:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2997427FB01;
	Tue, 22 Jul 2025 17:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f6+S8bM7"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B3127F16F;
	Tue, 22 Jul 2025 17:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753204717; cv=none; b=K+jgQb5iOMX0MhHdpmtGHUNXoG4mRU2pCYtHyYlR187EvmsyKbKs5QkP1LFuDqrCq/gE5fM5boPC3rdcpcioj+8sBEIInlc44/pmbcVYAy+Np4zepVVju8mviwIB0n+JZmcBY8TVf+xs6X20BvfGiKnYHCeVWOPBSShYpQkPPBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753204717; c=relaxed/simple;
	bh=UnNuwo/BfQjXh7XFgPBvTHasv/WlnvVIhRYKBEoO4OM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gioTTMj7fkh6QtD2JLFwh3Yyy3787KeG93gKqrFyET0ftdEZu23r3JR12TN0wdjYRfxxIzou8GgkZRra3+tXPQTuR6iIS0Yn8mfb8pdVin7T3Hiu1pqIM1GBMiSgJ0kn1/1Y0cs4vnk7PZROrX7UFSf9h7OLLsnllM9gNRUCk7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f6+S8bM7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E765C4CEF1;
	Tue, 22 Jul 2025 17:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753204716;
	bh=UnNuwo/BfQjXh7XFgPBvTHasv/WlnvVIhRYKBEoO4OM=;
	h=From:To:Cc:Subject:Date:From;
	b=f6+S8bM7CeQ3p9S6Tyot3Lnuz+8SKrMnJfPpK2LxFEdqhA0SpCo9mnXvn/etxb9lY
	 f3T5zLqsawoIV11hdjIsXrtTe1RUv52LRmsh4FM5AA5oeHFO8y+J/QrqINMJaCkC5R
	 sWcay7+pf0THhp8XKiGZRcMGVwJh+yBf4is6nuzysW3D4ROn2zC72KtmZnLTkxXbGU
	 TR/GFQBlf2ZxoGDngLY4PSwb3cUHQZDd5hKHuF9D8fGat76NCuP/0YUbCwOGiml0/r
	 r++qnlJohLskB46xLSp4ghvqSRq0d/sjCN8ET3l1eflD3ZnAMBhzY0EPbeeMNG2tk0
	 aa0UGSycZqmgw==
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
Subject: [PATCH net-next 0/3] net: Add sockaddr_inet unified address structure
Date: Tue, 22 Jul 2025 10:18:30 -0700
Message-Id: <20250722171528.work.209-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2090; i=kees@kernel.org; h=from:subject:message-id; bh=UnNuwo/BfQjXh7XFgPBvTHasv/WlnvVIhRYKBEoO4OM=; b=owGbwMvMwCVmps19z/KJym7G02pJDBn1x59fDJn7O3mP3sJrcp2XTuYsbeGNcX64IZBtnqjN6 4/tixoXd5SyMIhxMciKKbIE2bnHuXi8bQ93n6sIM4eVCWQIAxenAEyESYCR4XqOqQ5Hw+1lMo37 RQ6JmQbq/zyUv8m641KfrMDbptR9DowMm0+eOVsY+6FWc49m1/X79rmv23fr8jOkyHqHKjG5KnH zAwA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi!

Repeating patch 1, as it has the rationale:

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

Also includes the replacements for wireguard and sctp.

Thanks,

-Kees

Kees Cook (3):
  ipv6: Add sockaddr_inet unified address structure
  wireguard: peer: Replace sockaddr with sockaddr_inet
  sctp: Replace sockaddr with sockaddr_inet in sctp_addr union

 drivers/net/wireguard/peer.h | 2 +-
 include/linux/in6.h          | 7 +++++++
 include/net/sctp/structs.h   | 2 +-
 3 files changed, 9 insertions(+), 2 deletions(-)

-- 
2.34.1


