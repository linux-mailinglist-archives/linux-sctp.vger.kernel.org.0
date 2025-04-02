Return-Path: <linux-sctp+bounces-466-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B18A79011
	for <lists+linux-sctp@lfdr.de>; Wed,  2 Apr 2025 15:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38D7B188E467
	for <lists+linux-sctp@lfdr.de>; Wed,  2 Apr 2025 13:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44F123817C;
	Wed,  2 Apr 2025 13:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="atQnTlhn"
X-Original-To: linux-sctp@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873EB2376EA;
	Wed,  2 Apr 2025 13:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743601065; cv=none; b=aevId9dvFpiwqPVvn04wIT8CRkLBtZLN++U3ubrmoJ+0UzoBd02I2ApEpzoNQpQR5RD75V9MO1C8JoISRQ0z1HwAXc/T6jGzWPLSfZq3R9qs7UiL2v/H4Z/wQ6oC87vtbVMpV3eyA6KtuTUtPVXqbak03/e2vuslBABru4AfTu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743601065; c=relaxed/simple;
	bh=swpd2XtNMzz3kpxG6BhGNWoUL34duct8rpYe5rxi9/g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YkmfnDeCaKHISu2OFogEOKM9qLQxZZZ2hmwPvEpK/+bG1iMLiv1JbGRRSfi626+9DOrTbgmCHp+0ie/7MiK6XYbTpQ2ZVhCfMTGObHTtwL9nqDdr3KhWKisZCXWlwFePX3A8grVlTbLMJpRVcuCC9tFnFELaC6/OSzRcL/kpTRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=atQnTlhn; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=swpd2XtNMzz3kpxG6BhGNWoUL34duct8rpYe5rxi9/g=; b=atQnTlhnDVeymsrO7mq7AdM9cT
	gWmGJSigP5+KZAA7LJ/6rqIbLqn5Hj8eScXDZ7GVmJb6xnn08shXC9glA0IRr+BfGEQhJ3PfUA/tg
	cdQtD4HOodpUFg0CnISgCnHYQj7XM0zEDTbOIqpJeURjZug/DEzMV2LnKCwpDiCWJiOgKMGTKQ8p0
	5Z2eeCKpEOh3ZMLNqiwHreCJS1XslsXVhrZgw4tri7vvbcs6rdcov1h9pF90+AfgvZnXo80MQKeDA
	39ugXT27jhNfH0c7DD9zleT4QTIBYnIn54u2ZkIpxg2erB/sO+5kNz15D6rU/1J4BxhI/AF3ZPtye
	FMEP3BEw==;
Received: from 79.red-83-60-111.dynamicip.rima-tde.net ([83.60.111.79] helo=[192.168.1.72])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tzyHX-00AOOR-SM; Wed, 02 Apr 2025 15:37:27 +0200
Message-ID: <62dbd9ed967e43e7310cd5333867cfd8930321c4.camel@igalia.com>
Subject: Re: [PATCH] sctp: check transport existence before processing a
 send primitive
From: Ricardo =?ISO-8859-1?Q?Ca=F1uelo?= Navarro <rcn@igalia.com>
To: Simon Horman <horms@kernel.org>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long	
 <lucien.xin@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet	 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni	 <pabeni@redhat.com>, kernel-dev@igalia.com,
 linux-sctp@vger.kernel.org, 	netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Wed, 02 Apr 2025 15:37:27 +0200
In-Reply-To: <20250402132141.GO214849@horms.kernel.org>
References: 
	<20250402-kasan_slab-use-after-free_read_in_sctp_outq_select_transport-v1-1-da6f5f00f286@igalia.com>
	 <20250402132141.GO214849@horms.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Simon,

On Wed, 2025-04-02 at 14:21 +0100, Simon Horman wrote:
> Hi Ricardo,
>=20
> This is not a full review, and I would suggest waiting for one from
> others.
> But this will result in the local variable err being used
> uninitialised.
>=20
> Flagged by Smatch.

Nice catch! Thanks, I'll queue a fix for this for v2.

Cheers,
Ricardo

