Return-Path: <linux-sctp+bounces-339-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16220A33CF4
	for <lists+linux-sctp@lfdr.de>; Thu, 13 Feb 2025 11:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C67BF169613
	for <lists+linux-sctp@lfdr.de>; Thu, 13 Feb 2025 10:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0EA20E717;
	Thu, 13 Feb 2025 10:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mjzdBwKX"
X-Original-To: linux-sctp@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0716190477
	for <linux-sctp@vger.kernel.org>; Thu, 13 Feb 2025 10:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739443806; cv=none; b=KGGhjJTha55VN1oCfdiUooKkHemkfe4aAQIalCjOfymEfP5U8oFCBm6qk+gkGVy3JxbKPAdY33xt7G5pilwxo/7ey9wYaSf7hqJf9YSIY8EH+tlnjd/jc9xNNTwPgcTqdB1RZtmAyXSBPociWaAdTykhHCV3yiE0FEX8DyrVULo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739443806; c=relaxed/simple;
	bh=PZldEN6Abj+iXjTpspjBtDYDXPhcFFE2GIltlBfsO/w=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=O85h0UnasK3OQmMaFWS/5z4vdqtKPWDOP3KEl/FI78Wif5ik1guC7UzP1qiekeeM8tBXUFUGLYzrzv5XKhdi9MS/2oSUrVnUCLbbcl5RM43MONyY/o1HNMKjtQeOQB16XexnzVs+WA1/kUKNI+SZkQJJ7FK/ojfbcTQHVdejrjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mjzdBwKX; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739443798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PZldEN6Abj+iXjTpspjBtDYDXPhcFFE2GIltlBfsO/w=;
	b=mjzdBwKXjH97PHuJxlrFYl9NA4VqpM+GHmQl0XhlHLn82l4KtFXVZNKx1YkSpjao357yJN
	BdSs+mQcmyFRYpt7nyH5nlemg51obctsp+ED9ANbZo4kwWdVv/MMA1YTXmA/4OXjkAciDz
	bE7d2qjq+medOvjwao3I0MqwQNKws0A=
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH net-next] sctp: Remove commented out code
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <20250212195747.198419a3@kernel.org>
Date: Thu, 13 Feb 2025 11:49:45 +0100
Cc: Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Xin Long <lucien.xin@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 linux-sctp@vger.kernel.org,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F83DD790-9085-4670-9694-2668DACFB4C1@linux.dev>
References: <20250211102057.587182-1-thorsten.blum@linux.dev>
 <b85e552d-5525-4179-a9c4-6553b711d949@intel.com>
 <6F08E5F2-761F-4593-9FEB-173ECF18CC71@linux.dev>
 <2c8985fa-4378-4aa2-a56d-c3ca04e8c74c@intel.com>
 <20250212195747.198419a3@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
X-Migadu-Flow: FLOW_OUT

Hi Jakub,

> On 13. Feb 2025, at 04:57, Jakub Kicinski wrote:
> On Tue, 11 Feb 2025 12:33:57 +0100 Mateusz Polchlopek wrote:
>>>> I don't think we want to remove that piece of code, please refer
>>>> to the discussion under the link:
>>>>=20
>>>> =
https://lore.kernel.org/netdev/cover.1681917361.git.lucien.xin@gmail.com/ =
=20
>>>=20
>>> Hm, the commit message (dbda0fba7a14) says payload was deleted =
because
>>> "the member is not even used anywhere," but it was just commented =
out.
>>> In the cover letter it then explains that "deleted" actually means
>>> "commented out."
>>>=20
>>> However, I can't follow the reasoning in the cover letter either:
>>>=20
>>> "Note that instead of completely deleting it, we just leave it as a
>>> comment in the struct, signalling to the reader that we do expect
>>> such variable parameters over there, as Marcelo suggested."
>>>=20
>>> Where do I find Marcelo's suggestion and the "variable parameters =
over
>>> there?"
>>>=20
>>=20
>> That's good question, I can't find the Marcelo suggestion that author
>> mention. It's hard to find without links to previous series or
>> discussion :/
>>=20
>> I guess it should be also commented by maintainers, I see that in the
>> Xin's thread Kuba also commented change with commenting out instead
>> of removing code. Let's wait
>=20
> In the linked thread the point was to document what struct will be =
next
> in memory. Here we'd be leaving an array of u8s which isn't very
> informative. I see there's precedent in this file, but I vote we just
> delete the line.

This patch deletes the line and I'm wondering why the "cr"?

Were you referring to this patch maybe?
=
https://lore.kernel.org/r/20250114215439.916207-3-thorsten.blum@linux.dev/=


Should both payload fields just be deleted since they're not used?

Thanks,
Thorsten=

