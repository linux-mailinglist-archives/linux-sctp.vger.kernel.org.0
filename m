Return-Path: <linux-sctp+bounces-8-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17970846A90
	for <lists+linux-sctp@lfdr.de>; Fri,  2 Feb 2024 09:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CCCFB2845F
	for <lists+linux-sctp@lfdr.de>; Fri,  2 Feb 2024 08:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8EAA18C08;
	Fri,  2 Feb 2024 08:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="UtfEJPkm"
X-Original-To: linux-sctp@vger.kernel.org
Received: from forward205b.mail.yandex.net (forward205b.mail.yandex.net [178.154.239.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AAD18628;
	Fri,  2 Feb 2024 08:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706861810; cv=none; b=KlPpvfjVxv6QR/Bd6VSOMoElo79s7Fu5ieA28WB87BKvJhUyNNkCZe5jVTQPl+0vNctDkWUDyJiLszx8R8FkHUWeY70NQPgtIF2p5z9Nh0y3pi9xckffrxrNbPiNNSalBHGWeu4cFBSeWV0nQ6PvQbtAsoBhPCEOrqsp9MFuREI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706861810; c=relaxed/simple;
	bh=dyFkP540k5uwUKmQOZqkqe8E/2c94F4Jpy3jS5oNZ2o=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=TOUoT911w76/wDk5zgw1FzPsHDOGwb6IDOp9lJwbvvH8WCnDoLbTG3zMFz8NImslDOxnkw22HDRhYHaCl/VfpR5Cuq7XMjadnHFE7hddfpzORZm2j8+UxZv1Q+8nLXU6MQ4cdkxl7Wx6ravDqf/ItUk2tTini3uqbshfHgW65DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=UtfEJPkm; arc=none smtp.client-ip=178.154.239.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward103c.mail.yandex.net (forward103c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d103])
	by forward205b.mail.yandex.net (Yandex) with ESMTPS id DFF15626BD;
	Fri,  2 Feb 2024 11:16:43 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:5e15:0:640:5b6e:0])
	by forward103c.mail.yandex.net (Yandex) with ESMTPS id 5023360909;
	Fri,  2 Feb 2024 11:16:36 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id ZGXh9s7uIqM0-ip65dgjD;
	Fri, 02 Feb 2024 11:16:35 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1706861796; bh=tkXPLrm90NHw9N1zThe4QotB7/Rv/sUgKnlCs7whDfo=;
	h=To:Cc:From:Subject:Date:Message-ID;
	b=UtfEJPkm00lFY6obWr0KzLRis4rCTd/hxDs/qy2LeL92C+TP4X6Wx/L6rRbU2SJBb
	 3D25r5w91tFzxhdZi1XpOad70Ms8bCp71f91SXdJ1fzIJkfYgTSTyY4omBJJJ2x92f
	 ZvOsvco7jKjx4J2Xxa9nYvyAqgXLHRSv5RTx9xMw=
Authentication-Results: mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <8121e1f3-0c82-4764-85ff-b8e0b696adc8@yandex.ru>
Date: Fri, 2 Feb 2024 11:16:35 +0300
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: netdev@vger.kernel.org
Content-Language: en-US
Cc: linux-sctp@vger.kernel.org
From: Dmitry Antipov <dmantipov@yandex.ru>
Autocrypt: addr=dmantipov@yandex.ru; keydata=
 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
 tx98MCutXbJWn55RtnVKbpIiMfBrcB8=
Subject: Using skb_clone() after __skb_header_release()
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Is it legal to do Y = skb_clone(X) _after_ doing  __skb_header_release(X)?
(This seems happens in SCTP, and I'm interesting whether it might cause
https://syzkaller.appspot.com/bug?id=0d8351bbe54fd04a492c2daab0164138db008042).

Dmitry

