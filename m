Return-Path: <linux-sctp+bounces-592-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B199BB0F766
	for <lists+linux-sctp@lfdr.de>; Wed, 23 Jul 2025 17:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B3263B554B
	for <lists+linux-sctp@lfdr.de>; Wed, 23 Jul 2025 15:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C078178F4F;
	Wed, 23 Jul 2025 15:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aNQlQ22h"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B75F2F5B;
	Wed, 23 Jul 2025 15:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753285612; cv=none; b=Cb4vXOdeYuomT7dap+SDpv6Vj66rqVcayAwTWeeBCKKQfpi9jNPTFK7um9EA87Q6Z0xkCFJAEkcBfbfjregxbStKcEbv3Ui3wX/4SnD2/E0rp7vFVZ3EtjK29fbiKjKp2PGHf297Ku68Lt6Tr8egYdL3G6bg3jzELY7KIo6VR/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753285612; c=relaxed/simple;
	bh=ZjkFYW2U13Mn/AmyiaZUOzdKnfqib/AK/IkijJ/maJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MyFzKB3MwDmeJtdF9teCjTTxWabSyb5jABKlCFSfoZssTWjMRP9tgPpNS50kfG0vZhBsTTgSzv6cpN3bf2eJopLHVTjt0UXv1AltUUsgEnslAbBEMSl790os5e/FynB1IfogtlxNfS/BcI8wAOl5KRcWRDBhAKxq7OcAxjwODMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aNQlQ22h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C75C4CEE7;
	Wed, 23 Jul 2025 15:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753285612;
	bh=ZjkFYW2U13Mn/AmyiaZUOzdKnfqib/AK/IkijJ/maJM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aNQlQ22hhTYDAPi/lRwAWj2qwUsXFOufz2OH9a9kWha+0ZAdtGQ93nBfhCsm8j9Rz
	 cMzRiQamF7jCzbfh3hsopUlr63HJM+GBVtVcNbxvMv+xT+v3qL5lSrRMNL5zy975DG
	 3ICxz03o8VjYbcwc9w8gDyQvogFZ2i3j3sJlnPf5v4juKizkbQrXmjJxhxE55pRIqa
	 1pbA6bL7MGDCcJvsJ5C3v2fwaVkWys2akT3KdRpMt5jqUJEJK+50AOlgavBqkPSrjM
	 US71vAw/WrEL/FmlQymCQmmQLKtUVLMJu02zmdsO0UCD4aVK4EAgfvNb+HU9C9wj/q
	 wKxS3sFVQzoaA==
Date: Wed, 23 Jul 2025 16:46:47 +0100
From: Simon Horman <horms@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Xin Long <lucien.xin@gmail.com>, linux-kernel@vger.kernel.org,
	wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
	linux-sctp@vger.kernel.org, linux-hardening@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next 0/3] net: Add sockaddr_inet unified address
 structure
Message-ID: <20250723154647.GI1036606@horms.kernel.org>
References: <20250722171528.work.209-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722171528.work.209-kees@kernel.org>

+ Iwashima-san and Willem

  This series looks like something you should review

On Tue, Jul 22, 2025 at 10:18:30AM -0700, Kees Cook wrote:
> Hi!
> 
> Repeating patch 1, as it has the rationale:
> 
>     There are cases in networking (e.g. wireguard, sctp) where a union is
>     used to provide coverage for either IPv4 or IPv6 network addresses,
>     and they include an embedded "struct sockaddr" as well (for "sa_family"
>     and raw "sa_data" access). The current struct sockaddr contains a
>     flexible array, which means these unions should not be further embedded
>     in other structs because they do not technically have a fixed size (and
>     are generating warnings for the coming -Wflexible-array-not-at-end flag
>     addition). But the future changes to make struct sockaddr a fixed size
>     (i.e. with a 14 byte sa_data member) make the "sa_data" uses with an IPv6
>     address a potential place for the compiler to get upset about object size
>     mismatches. Therefore, we need a sockaddr that cleanly provides both an
>     sa_family member and an appropriately fixed-sized sa_data member that does
>     not bloat member usage via the potential alternative of sockaddr_storage
>     to cover both IPv4 and IPv6, to avoid unseemly churn in the affected code
>     bases.
> 
>     Introduce sockaddr_inet as a unified structure for holding both IPv4 and
>     IPv6 addresses (i.e. large enough to accommodate sockaddr_in6).
> 
>     The structure is defined in linux/in6.h since its max size is sized
>     based on sockaddr_in6 and provides a more specific alternative to the
>     generic sockaddr_storage for IPv4 with IPv6 address family handling.
> 
>     The "sa_family" member doesn't use the sa_family_t type to avoid needing
>     layer violating header inclusions.
> 
> Also includes the replacements for wireguard and sctp.
> 
> Thanks,
> 
> -Kees
> 
> Kees Cook (3):
>   ipv6: Add sockaddr_inet unified address structure
>   wireguard: peer: Replace sockaddr with sockaddr_inet
>   sctp: Replace sockaddr with sockaddr_inet in sctp_addr union
> 
>  drivers/net/wireguard/peer.h | 2 +-
>  include/linux/in6.h          | 7 +++++++
>  include/net/sctp/structs.h   | 2 +-
>  3 files changed, 9 insertions(+), 2 deletions(-)
> 
> -- 
> 2.34.1
> 

