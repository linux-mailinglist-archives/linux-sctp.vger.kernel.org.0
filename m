Return-Path: <linux-sctp+bounces-576-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AA3AD6EE6
	for <lists+linux-sctp@lfdr.de>; Thu, 12 Jun 2025 13:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 740DD7ADC7F
	for <lists+linux-sctp@lfdr.de>; Thu, 12 Jun 2025 11:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0282023D2B3;
	Thu, 12 Jun 2025 11:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="PZ0P+aa3"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FAE23D29F
	for <linux-sctp@vger.kernel.org>; Thu, 12 Jun 2025 11:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749727273; cv=none; b=GJi8iNaXQYEnbra5FhPq/6NXqx8ti+abD/kqMmFqnXfF4QiUv5ynI/3DDD/Gvm9GHtm3ss3kuLdrtFS0TCwkNlXcvcP+82R3unOsejV+O/ly0WX6pRKbzAotyEWU0LV2ZoPpQZNPpKsaiWpnFDsrPgpBnHWiJIV4GHiCs6qd46Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749727273; c=relaxed/simple;
	bh=g3kFQaxgMZqaZs3yTqAocJ8TzOltj9uv2BWplJ8Q0+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HrxkVYGw22bsX5Noi4mRYFEpOKUZOi9Fsl2Hl0bJwwu21QoAyP3GZcvCDnHoOVlbIj6I07syM8aiw1NeQqsTN1tHlJWkle6P/17lFZM9PKIXqL4KxpoJlbz2CrNFaK5vO0Rr5VNjc/K7A6nQUMIE244h5eEM5WtDi6+gfq4PNh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=PZ0P+aa3; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6088d856c6eso868363a12.0
        for <linux-sctp@vger.kernel.org>; Thu, 12 Jun 2025 04:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1749727269; x=1750332069; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=izHnPXiYoTBneokvv1hu9m+7dLFok2Jhf1Nqy0rykvY=;
        b=PZ0P+aa3jUGdyMDblBlczmn0K+F/S5C5BJTeFCCAEjLGNwDNufC775iO3ZoZcrE5tQ
         gL3g+btdTnxkTCToBS80lFsUCH8LgVsAFpxcReTDx9PRzYxpjbV0NQZMNp5X6PUfpAIq
         cvH8DYPqne9BCM4bRn9ceijVy3R4ghZsI/bsYVrNIRdV6G3ESRh3YVepvp3CCIVrzrbx
         hbS7nMpusZ68JoaZP/E4jYdT1CyDtLUhdmWA2DsP7js4CWYVnOSH9yQtC1lbOAypgm9t
         lAI+HqsePWHMA/D0nX12NRpdEG3JFH27nxbCLKFiFQ3iaBVHt5FcjXVED+e9KLadwRdk
         gkRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749727269; x=1750332069;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=izHnPXiYoTBneokvv1hu9m+7dLFok2Jhf1Nqy0rykvY=;
        b=So3EXCTVoZj0kqzN9etOkIy+HpCthDWC//Bxd9xaIL97CNpmA4Beq2YP1hq4Wk0tM+
         Iqh3KQypNIo3bNV0+H0wvJGkCEvB0/cZND7FU7Ht9M5ZDQ0ACpV+IYx0p3RoBet+bkPC
         b2U96XTPfc2LGnpFTlao0Is/heCZQ4ez481G85kcYhhGF81n/BlwKXvk24ZlWSC4MED5
         HiBYp58Y+qtwGXL/js4USJ+9j5CZyIAOa/dfH+fRT4RFXwI5TZ6T87BJldL0I+PBc0nJ
         EVsysRjiuoDhAO9OneYDi8L16gP4uNYMrSyGnll6TOhXQ3eMgIGy9u4RE7wcGiD+wPN1
         A8vw==
X-Forwarded-Encrypted: i=1; AJvYcCUkTRkr3JZ3zmKrMT7fj5krMNJMvoqLaDrGvbh4UyGzvV8tit1c392emVX3NA6/Il8P/XUubinN0POH@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8mtK87Pe3jdnwPS/G0DR/ZsagXQ7XgpDuCLRWQzgsqotx8QX/
	PEtSKI5jpJWMpVW+Vb52R3OCDQBlJTK0NXOzknd0XZ/TViX88r+ThxRoWVPOD+mflp+oIaqtlFp
	CNO+45NEqGi/ZOtHcSNz3JVN1RMIBo//tu570qubZJDyNRP5YNJn3bZik
X-Gm-Gg: ASbGncthTrskqDh9xLYfWKcJcSsy3b/nfOnMfZ/G2hZA0Opx6vHODtpuci5NGhC6TQG
	NvsiKe9rpg9rnSfU9LMf+Zd6JG2ineOjgntUhGuClvQdBz2cowcPGtyI3df6B5vICnijuQ8BCLG
	uwYrzrCuRPi2HFUpwhXqAornBMAYiXJbTzJ9l414yqg7Crsrbh7YFF3MXznL3KO5tfZDvrl0jD9
	/KZku7cKd0vUc0wp/osYTASOwL72Z9wxsbHtxss6F3Z1Cjhe9xgUySsJG6/guDTO+gdd5IibRRm
	YK16koeluvaZKSEwJ1slxHyRflBoxfkmpzju4+HcgfrdDqtmlsLtD//bY/SR9pS2I10fqhMf0I2
	hmf3keFkn3BwPZFdKIzBwCQ==
X-Google-Smtp-Source: AGHT+IG32Jgp4TMA7lCBexDTcDiVY2kbdEbExXQqe7eQtCA22E2tcCY1TdJFi3Ti5SLLEYiXvj7ozw==
X-Received: by 2002:a17:907:7f03:b0:ad8:9257:573a with SMTP id a640c23a62f3a-ade893dfcf7mr630132366b.5.1749727269216;
        Thu, 12 Jun 2025 04:21:09 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:66f3:a0b:4137:82f3? ([2001:67c:2fbc:1:66f3:a0b:4137:82f3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adeadf204ffsm118284366b.171.2025.06.12.04.21.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 04:21:08 -0700 (PDT)
Message-ID: <faa9f6a8-daea-40f7-82dd-fb1133010629@openvpn.net>
Date: Thu, 12 Jun 2025 13:21:06 +0200
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 01/14] net: ipv4: Add a flags argument to
 iptunnel_xmit(), udp_tunnel_xmit_skb()
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@gmail.com>,
 netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Nikolay Aleksandrov
 <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, mlxsw@nvidia.com,
 Pablo Neira Ayuso <pablo@netfilter.org>, osmocom-net-gprs@lists.osmocom.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, Taehee Yoo <ap420073@gmail.com>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>, wireguard@lists.zx2c4.com,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 linux-sctp@vger.kernel.org, Jon Maloy <jmaloy@redhat.com>,
 tipc-discussion@lists.sourceforge.net
References: <cover.1749499963.git.petrm@nvidia.com>
 <c77a0c8e4ada63a0a69d7011fb901703ebf1f09a.1749499963.git.petrm@nvidia.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <c77a0c8e4ada63a0a69d7011fb901703ebf1f09a.1749499963.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/06/2025 22:50, Petr Machata wrote:
> iptunnel_xmit() erases the contents of the SKB control block. In order to
> be able to set particular IPCB flags on the SKB, add a corresponding
> parameter, and propagate it to udp_tunnel_xmit_skb() as well.
> 
> In one of the following patches, VXLAN driver will use this facility to
> mark packets as subject to IP multicast routing.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
> 
> Notes:
> CC: Pablo Neira Ayuso <pablo@netfilter.org>
> CC: osmocom-net-gprs@lists.osmocom.org
> CC: Andrew Lunn <andrew+netdev@lunn.ch>
> CC: Taehee Yoo <ap420073@gmail.com>
> CC: Antonio Quartulli <antonio@openvpn.net>
> CC: "Jason A. Donenfeld" <Jason@zx2c4.com>
> CC: wireguard@lists.zx2c4.com
> CC: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
> CC: linux-sctp@vger.kernel.org
> CC: Jon Maloy <jmaloy@redhat.com>
> CC: tipc-discussion@lists.sourceforge.net

Acked-by: Antonio Quartulli <antonio@openvpn.net>


-- 
Antonio Quartulli
OpenVPN Inc.


