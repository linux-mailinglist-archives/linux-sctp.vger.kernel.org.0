Return-Path: <linux-sctp+bounces-14-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBAD84F2ED
	for <lists+linux-sctp@lfdr.de>; Fri,  9 Feb 2024 11:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35BA7B23732
	for <lists+linux-sctp@lfdr.de>; Fri,  9 Feb 2024 10:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D41067E61;
	Fri,  9 Feb 2024 10:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="piz3haEe"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E5867E62
	for <linux-sctp@vger.kernel.org>; Fri,  9 Feb 2024 10:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707473157; cv=none; b=k8XdghrRTJJORaN6Ifl3tCUWT75J+JGnF8JnFtfTOv+BuQffdlG47rHbLbqF/8MTjOZogcUKJiEoz2PsRYdmvRDXyenxeP9a6Qb6aU/G940r3rUhzWUH+6EC/8NiHClexBTfFZAaxs7gWhzlMbk2DnL+3YZ4Au7XcsceFFIHLaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707473157; c=relaxed/simple;
	bh=EI69GMUlRYuU3UuDomYXIBwyqJWDk5ZOT+aJNpPF5WA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=BdmKxEtR5ePg6Xdu9LuhkJ/9I23Zc4hv4749EaFCfzFzgvOZ5uSWgD1I/4LEB0tvD1kkOaGpcptJgE32V8Mu5ErUEqXQeI/6Z2IE02kQzGoWjUwnwFrcIyVVxPn75S0TDbPMmQ7HRClww/FRgSc2EA/ZjfmvXaWvDgEJctVGs3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=piz3haEe; arc=none smtp.client-ip=212.27.42.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from zimbra101-e18.priv.proxad.net (unknown [172.20.243.47])
	by smtp6-g21.free.fr (Postfix) with ESMTP id DF8C8780368;
	Fri,  9 Feb 2024 11:05:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1707473146;
	bh=EI69GMUlRYuU3UuDomYXIBwyqJWDk5ZOT+aJNpPF5WA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=piz3haEe8QR4g+0QsDxlB/KWV1cNR7Js3P20/cg0OKU5LOioQr1JCnePAp6LqIi7V
	 dEwrG8HGY7LR4wPnrY0nTKFWnMdrH9GINf623VHyaD8HILzgsClF0wTDrBnxhe9sx3
	 jMg+uidyNbtjdbF/EE7Cp/WNarOTI82+gNIUR+ePCopQ+qtYp0bS+Z7y4nmBbZpmhx
	 Dx0CarPCwjj90wxralZDvw2xGvrl/7qM6lorgaz2UQ69Yhsj2nXHELB3XvBqAVoNIF
	 xF2LQ7Ht7ZaYagyx8VHE8gr5YZApu2GgnuZLZsteYntt36xemSgJRp4nMjlBatIBzp
	 J2z8D4tsUJ+jQ==
Date: Fri, 9 Feb 2024 11:05:46 +0100 (CET)
From: o.evistel@free.fr
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: linux-sctp <linux-sctp@vger.kernel.org>
Message-ID: <1024792113.114715673.1707473146836.JavaMail.zimbra@free.fr>
In-Reply-To: <1937458162.418765580.1657717120765.JavaMail.zimbra@free.fr>
References: <6f6f11b5c30bce3d6e77d719ef75112dee75250d.profile@marceloleitner.u.sourceforge.net> <YsbiDrG1PQ2Gng5T@t14s.localdomain> <1937458162.418765580.1657717120765.JavaMail.zimbra@free.fr>
Subject: Linux SCTP multihoming question
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Disposition-Notification-To: "" <o.evistel@free.fr>
X-Mailer: Zimbra 8.8.7_GA_1002 (ZimbraWebClient - FF122 (Linux)/8.8.7_GA_1002)
Thread-Topic: Linux SCTP multihoming question
Thread-Index: 2DGxpN6xV4C4bUClvJnyXq7vayuHv9PIuklE


Dear Marcelo

I am using linux-sctp as transport for SIGTRAN M3UA on RHEL 8.4 with multihoming (sctp_bindx(), sctp_connectx() API functions).
I would like to know, after association setup, if it is possible to instruct SCTP to use a specific local address from the list of bound addresses to reach the peer.

Regards
Omar AIT AMRANE

