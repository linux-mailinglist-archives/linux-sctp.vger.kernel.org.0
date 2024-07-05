Return-Path: <linux-sctp+bounces-177-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DEF5928454
	for <lists+linux-sctp@lfdr.de>; Fri,  5 Jul 2024 11:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95D51B25522
	for <lists+linux-sctp@lfdr.de>; Fri,  5 Jul 2024 09:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDBF1448D4;
	Fri,  5 Jul 2024 09:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZSMrsSq"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2006313665A;
	Fri,  5 Jul 2024 09:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720170028; cv=none; b=f3mIAzAF3/Z0UGxI3/nGhUW2U47hgIPmdEb+H6sZgzxGLSLvxvvn3mrnN6pTKZMIiB4OnDBBhOEd0+P7QVinmyWfH0xuVYI2ixncwiT1OGcawi6Q1QlJ/2+nlJWDGyBZRS3CNRPH11VkeerSSCkK47Ey7mcAQ0+noTo6UnWPlyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720170028; c=relaxed/simple;
	bh=jCIa6Irq0nM9w7hMNIpO+QJ8zw8JIKXblUcXVR/HfnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bdf3haq8nOPao0YD4tbKpGL76qJSc54S0BRtiRFUlwWZkR2/MgoVN/YQ52WGwNm1RAnZClqYZC76wJE+hvbH55PvWRVkVvRxJE2PMIhq9yPSQoX3ucjU7J/uQX141IBAMnUwe84SxFKpHCINMaI71LgHtXAWU5N/weH4FhGScB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZSMrsSq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94301C116B1;
	Fri,  5 Jul 2024 09:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720170027;
	bh=jCIa6Irq0nM9w7hMNIpO+QJ8zw8JIKXblUcXVR/HfnQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gZSMrsSqFO51LxSMpP7oLFTm0zBE1ZrvMEN+6osXYHfwGEPBpSHJxeM1bGMQuvW2h
	 AqDRSc7VjcP2bHmq322O2S1zrON25/iu8ljsf2+ZLqJPbEvSkh3Yzr4mDcSYbcyPYX
	 9z2/NOHo6TDMP/ixsP2ZtAO8MwXF5ACpucXAvYL8ljfkjeRrHze1MtFNPjMTfOgVf1
	 Vxi3Fltz70DAqxca5uowsDEmmAEc6g7m1WcAkoYGb79VzLoUAqGsCOLry/KzF9uDmU
	 Et11vYQ220nPGNqhAJCp/FJLm/Mvj0Lm+ifF+LyJk1um+wLUvpmW0ClcBbo7TqY1dg
	 CHYdeotabNhgQ==
Date: Fri, 5 Jul 2024 10:00:23 +0100
From: Simon Horman <horms@kernel.org>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: marcelo.leitner@gmail.com, lucien.xin@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] sctp: Fix typos and improve comments
Message-ID: <20240705090023.GB1095183@kernel.org>
References: <20240704202558.62704-2-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704202558.62704-2-thorsten.blum@toblux.com>

On Thu, Jul 04, 2024 at 10:25:59PM +0200, Thorsten Blum wrote:
> Fix typos s/steam/stream/ and spell out Schedule/Unschedule in the
> comments.
> 
> Compile-tested only.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>

Reviewed-by: Simon Horman <horms@kernel.org>


