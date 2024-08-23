Return-Path: <linux-sctp+bounces-210-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEFB95C4F6
	for <lists+linux-sctp@lfdr.de>; Fri, 23 Aug 2024 07:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C2F31C2420D
	for <lists+linux-sctp@lfdr.de>; Fri, 23 Aug 2024 05:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF0054F8C;
	Fri, 23 Aug 2024 05:45:38 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D21C2AD13;
	Fri, 23 Aug 2024 05:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724391938; cv=none; b=YKFR1/o4+82JO/wOtZg42/GNCOJ/uKf+FS6R64ouTE2iRRb8X7w2bOzdd5PgSd+o0uZow2S5elT9ZQsykwsFWLWAK7h0XacwITNk1ZNp+coZ9xFZWzKGj952/2zML926F3GYmQ0twhYqd9OR/wZJMC4fewOdyzyEfmuv5ASKbyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724391938; c=relaxed/simple;
	bh=1l9KiEndT9zt6GVmnb63XbT8mlKSHSFifT/I4dlh/sA=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=LISqZ4iOGOXft9WMQ6U/b+sQilL+8dIxXjMlg1i2B+mPm6U6AGox6/E/faApsZ7LZttomJHq+pKPYddkGGXzPnaxDkrSzE3SpM1d9fwghp+TcqtUklCPIxfG356Ue36Bf34sQyo1wZhooc2D/HKx9eGE6Rd5l1uVyeHgwVQ+zvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=297933add1=ms@dev.tdt.de>)
	id 1shMpm-00Ermz-Hw; Fri, 23 Aug 2024 07:27:38 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1shMpm-000Bnw-01; Fri, 23 Aug 2024 07:27:38 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 8ABF9240042;
	Fri, 23 Aug 2024 07:27:37 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 4CD8D240036;
	Fri, 23 Aug 2024 07:27:37 +0200 (CEST)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id 6B6FC39D24;
	Fri, 23 Aug 2024 07:27:36 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 23 Aug 2024 07:27:36 +0200
From: Martin Schiller <ms@dev.tdt.de>
To: Simon Horman <horms@kernel.org>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexandra Winter
 <wintera@linux.ibm.com>, Thorsten Winkler <twinkler@linux.ibm.com>, David
 Ahern <dsahern@kernel.org>, Jay Vosburgh <jv@jvosburgh.net>, Andy Gospodarek
 <andy@greyhouse.net>, Subash Abhinov Kasiviswanathan
 <quic_subashab@quicinc.com>, Sean Tranchetti <quic_stranche@quicinc.com>,
 Paul Moore <paul@paul-moore.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>, Marcelo Ricardo Leitner
 <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>,
 netdev@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-sctp@vger.kernel.org,
 linux-x25@vger.kernel.org
Subject: Re: [PATCH net-next 11/13] x25: Correct spelling in x25.h
Organization: TDT AG
In-Reply-To: <20240822-net-spell-v1-11-3a98971ce2d2@kernel.org>
References: <20240822-net-spell-v1-0-3a98971ce2d2@kernel.org>
 <20240822-net-spell-v1-11-3a98971ce2d2@kernel.org>
Message-ID: <63470d95781b010695d97dcd8c1c9fe0@dev.tdt.de>
X-Sender: ms@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-purgate-type: clean
X-purgate-ID: 151534::1724390858-93C5B34D-86652F55/0/0
X-purgate: clean

On 2024-08-22 14:57, Simon Horman wrote:
> Correct spelling in x25.h
> As reported by codespell.
> 
> Cc: Martin Schiller <ms@dev.tdt.de>
> Cc: linux-x25@vger.kernel.org
> Signed-off-by: Simon Horman <horms@kernel.org>
> ---
>  include/net/x25.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/net/x25.h b/include/net/x25.h
> index 597eb53c471e..5e833cfc864e 100644
> --- a/include/net/x25.h
> +++ b/include/net/x25.h
> @@ -81,7 +81,7 @@ enum {
> 
>  #define	X25_DEFAULT_WINDOW_SIZE	2			/* Default Window Size	*/
>  #define	X25_DEFAULT_PACKET_SIZE	X25_PS128		/* Default Packet Size */
> -#define	X25_DEFAULT_THROUGHPUT	0x0A			/* Deafult Throughput */
> +#define	X25_DEFAULT_THROUGHPUT	0x0A			/* Default Throughput */
>  #define	X25_DEFAULT_REVERSE	0x00			/* Default Reverse Charging */
> 
>  #define X25_SMODULUS 		8

Reviewed-by: Martin Schiller <ms@dev.tdt.de>

